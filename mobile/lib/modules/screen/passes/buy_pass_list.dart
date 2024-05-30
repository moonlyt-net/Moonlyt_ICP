import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moonlyt/modules/screen/navigation/my_bottom_navigation_bar.dart';
import 'package:moonlyt/modules/screen/passes/pass_view_model.dart';

class MoonPassView extends ConsumerStatefulWidget {
  const MoonPassView({super.key});

  @override
  ConsumerState<MoonPassView> createState() => _MoonPassViewState();
}

class _MoonPassViewState extends ConsumerState<MoonPassView> {
  @override
  Widget build(BuildContext context) {
    final contents = ref.watch(contentListProvider);
    return WillPopScope(
      onWillPop: () async {
        ref.read(selectedIndexProvider.notifier).state = 0;
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset('assets/background_dark.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                      child: Text(
                        "Moonpass",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 20),
                        shrinkWrap: true,
                        itemCount: contents.length,
                        itemBuilder: (context, index) {
                          final content = contents[index];
                          return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              width: double.infinity,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.2),
                                border:
                                    Border.all(color: Colors.white, width: 0.5),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      content.thumbnail,
                                      width: 120,
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 170,
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          content.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Share Ratio(65%)",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "This refers to the share ratio in webtoons",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              180,
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.all(2),
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200], // 배경색
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: FractionallySizedBox(
                                            widthFactor:
                                                content.currentPurchases /
                                                    content.maxIssuance,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xFFFF6C2D)
                                                        .withOpacity(0.3),
                                                    Color(0xFFFFD53E),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              context.pushNamed('pass', pathParameters: {
                                'title': content.title,
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
