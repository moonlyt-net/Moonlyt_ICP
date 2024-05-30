import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moonlyt/modules/model/mission.dart';
import 'package:moonlyt/modules/model/pass_content.dart';
import 'package:moonlyt/modules/screen/mypage/my_moonpass_view_model.dart';
import 'package:moonlyt/modules/screen/passes/pass_info/pass_info_view.dart';
import 'package:moonlyt/modules/screen/passes/pass_view_model.dart';
import 'package:moonlyt/modules/wallet/transaction_view_model.dart';
import 'package:moonlyt/modules/wallet/wallet_balance_view_model.dart';

class PassView extends ConsumerStatefulWidget {
  const PassView({required this.title, super.key});
  final String title;

  @override
  ConsumerState<PassView> createState() => _PassViewState();
}

class _PassViewState extends ConsumerState<PassView> {
  int selectedPreview = 0;

  void _onTabTap(int index) {
    setState(() {
      selectedPreview = index;
    });
  }

  Widget _buildPreview(Content content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(content.preview,
          style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }

  Widget _buildBenefits(Content content) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 4.0,
      children: content.benefits
          .map((benefit) => Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: Text(
                  benefit,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildMission(Content content) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: content.missions.length,
      itemBuilder: (context, index) {
        Mission mission = content.missions[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          padding: const EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Text(
                  mission.content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                child: Text(
                  '${mission.point} P',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void insufficientBalance() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Colors.white, width: 1.0)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: const Color(0xFF333333).withOpacity(0.8),
            content: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              height: 50,
              width: 100,
              child: const Text("Insufficient balance"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final content = ref.watch(contentListProvider).firstWhere(
          (element) => element.title == widget.title,
        );
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/background_dark.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  color: Colors.white.withOpacity(0.2),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 210,
                      ),
                      Text(
                        content.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            content.genres.length,
                            (index) => Container(
                              margin: const EdgeInsets.only(top: 5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                content.genres[index],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => PassInfoView(
                                  index: index,
                                  isSelected: selectedPreview == index,
                                  onTap: _onTabTap,
                                )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (selectedPreview == 0)
                  Expanded(child: _buildPreview(content)),
                if (selectedPreview == 1)
                  Expanded(child: _buildBenefits(content)),
                if (selectedPreview == 2)
                  Expanded(child: _buildMission(content)),
              ],
            ),
            Container(
              height: 200.0, // 컨테이너 높이
              width: double.infinity, // 컨테이너 너비를 부모에 맞춤
              decoration: BoxDecoration(
                color: Colors.white, // 컨테이너 배경 색상
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2), // 그림자 색상 및 투명도
                    spreadRadius: 5, // 그림자 확산 반경
                    blurRadius: 100, // 그림자 흐림 효과
                    offset: Offset(0, 3), // 수평 및 수직 방향으로 그림자 오프셋
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20.0)),
                child: Image.asset(
                  content.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 90,
              left: 40,
              right: 40,
              child: GestureDetector(
                onTap: () {
                  if (ref
                      .read(myPassListProvider)
                      .any((pass) => pass.title == content.title)) {
                    return;
                  }
                  if (ref.read(walletBalanceProvider).balance < content.price) {
                    insufficientBalance();
                    return;
                  }
                  ref
                      .read(contentListProvider.notifier)
                      .incrementCurrentPurchases(content.title);
                  ref
                      .read(walletBalanceProvider.notifier)
                      .updateBalance(-content.price.toDouble());
                  ref
                      .read(transactionRecordsProvider.notifier)
                      .addTransactionRecord(
                          DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          -content.price.toDouble(),
                          'Purchase ${content.title}');
                  ref.read(myPassListProvider.notifier).addPassList(
                      content.title,
                      content.missions,
                      content.thumbnail,
                      content.benefits);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF004C),
                          Color(0xFFFF773E),
                        ],
                      ),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: ref
                            .read(myPassListProvider)
                            .any((pass) => pass.title == content.title)
                        ? Center(
                            child: Text("Collaborator",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${NumberFormat(
                                  '#,##0',
                                ).format(content.price)} MYLT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Buy",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
