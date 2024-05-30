import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moonlyt/modules/screen/mypage/my_moonpass_view_model.dart';
import 'package:moonlyt/modules/screen/navigation/my_bottom_navigation_bar.dart';

class MyMoonPassView extends ConsumerStatefulWidget {
  const MyMoonPassView({super.key});

  @override
  ConsumerState<MyMoonPassView> createState() => _MyMoonPassViewState();
}

class _MyMoonPassViewState extends ConsumerState<MyMoonPassView> {
  @override
  Widget build(BuildContext context) {
    final moonpass = ref.watch(myPassListProvider);
    debugPrint("======= MyMoonPassView =======");
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
                        "My Moonpass",
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
                        itemCount: moonpass.length,
                        itemBuilder: (context, index) {
                          final pass = moonpass[index];
                          return GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 15),
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
                                      pass.thumbnail,
                                      width: 120,
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pass.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "current proceed",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "Date elapsed from date of purchase",
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
                              context.pushNamed('dao',
                                  pathParameters: {'title': pass.title});
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
