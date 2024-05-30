import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moonlyt/modules/model/pass_content.dart';
import 'package:moonlyt/modules/screen/passes/pass_info/pass_info_view.dart';
import 'package:moonlyt/modules/screen/webtoon/webtoon_view_model.dart';

class WebtoonDetailView extends ConsumerWidget {
  const WebtoonDetailView({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webtoonContent = ref.watch(webtoonContentsProvider).firstWhere(
          (element) => element.id == id,
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250.0, // 컨테이너 높이
                    width: double.infinity, // 컨테이너 너비를 부모에 맞춤
                    decoration: BoxDecoration(
                      color: Colors.white, // 컨테이너 배경 색상
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20.0),
                      ),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        webtoonContent.imagePath,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.white.withOpacity(0.15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          webtoonContent.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          height: 20,
                          child: Text(
                            'by ${webtoonContent.address.substring(0, 6)}...${webtoonContent.address.substring(webtoonContent.address.length - 6)}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: webtoonContent.genres.map((genre) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              margin: EdgeInsets.only(right: 5),
                              height: 15,
                              child: Text(
                                textAlign: TextAlign.center,
                                '# ${genre}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    itemCount: webtoonContent.comics.length,
                    itemBuilder: (context, index) {
                      final webtoon = webtoonContent.comics[index];
                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 15, right: 20, left: 20),
                          padding: const EdgeInsets.all(5),
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.2),
                            border: Border.all(color: Colors.white, width: 0.5),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  webtoon.imagePaths.first,
                                  width: 80,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ep ${index + 1} : ${webtoon.title}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      webtoon.date,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    (webtoon.price != 0)
                                        ? Text(
                                            NumberFormat.currency(
                                              locale: 'ko_KR',
                                              symbol: '₩',
                                            ).format(webtoon.price),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          )
                                        : Text(
                                            'Free',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          // context.pushNamed('webtoon_page', pathParameters: {
                          //   'id': webtoon.id,
                          // });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
