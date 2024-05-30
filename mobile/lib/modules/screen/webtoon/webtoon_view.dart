import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moonlyt/modules/screen/webtoon/webtoon_view_model.dart';

class WebtoonView extends ConsumerStatefulWidget {
  const WebtoonView({super.key});

  @override
  ConsumerState<WebtoonView> createState() => _WebtoonViewState();
}

class _WebtoonViewState extends ConsumerState<WebtoonView> {
  final ScrollController _selectController = ScrollController();
  int _selectedIndex = 0;

  List<String> _genreList = [
    "Romance",
    "action",
    "drama",
    "fantasy",
    "comedy",
    "slice of life",
  ];

  void _scrollToIndex(int index) {
    debugPrint("index: $index ");
    final double desiredPosition = (120.0 * index);
    _selectController.animateTo(
      desiredPosition,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final webtoonContents = ref.watch(webtoonContentsProvider);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/background_dark.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   color: Colors.grey.withOpacity(0.3),
          // ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Find your identity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 20),
                    const SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('popular Webtoons',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Text('checkout what everyone is reading!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 240,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: webtoonContents.length,
                            itemBuilder: (context, index) {
                              final webtoonContent = webtoonContents[index];
                              return GestureDetector(
                                onTap: () {
                                  context.pushNamed('webtoon_detail',
                                      pathParameters: {
                                        'id': webtoonContent.id.toString(),
                                      });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    right: 10,
                                    left: 10,
                                  ),
                                  width: 150,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    // image: DecorationImage(
                                    //   image: AssetImage('assets/webtoon1.png'),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.zero,
                                          padding: EdgeInsets.zero,
                                          width: 130,
                                          height: 130,
                                          child: Image.asset(
                                            webtoonContent.imagePath,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: webtoonContent.genres
                                              .map((genre) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              margin: EdgeInsets.only(right: 5),
                                              height: 15,
                                              color: Colors.grey.shade300,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                genre,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        webtoonContent.title,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.thumb_up_outlined,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.collections_bookmark_outlined,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.white.withOpacity(0.2),
                          ),
                          height: 60,
                          child: ListView.builder(
                            controller: _selectController,
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              if (index < 6) {
                                return GestureDetector(
                                  onTap: () => _scrollToIndex(index),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.bottomCenter,
                                    margin: EdgeInsets.only(right: 10),
                                    width: 110,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: _selectedIndex == index
                                              ? Colors.white
                                              : Colors.transparent,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "${_genreList[index]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: webtoonContents.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final webtoonContent = webtoonContents[index];
                        return GestureDetector(
                          onTap: () {
                            debugPrint('test');
                            context
                                .pushNamed('webtoon_detail', pathParameters: {
                              'id': webtoonContent.id.toString(),
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              // image: DecorationImage(
                              //   image: AssetImage('assets/webtoon1.png'),
                              //   fit: BoxFit.cover,
                              // ),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero,
                                    width: 160,
                                    height: 160,
                                    child: Image.asset(
                                      webtoonContent.imagePath,
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children:
                                        webtoonContent.genres.map((genre) {
                                      return Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        margin: EdgeInsets.only(right: 5),
                                        height: 15,
                                        color: Colors.grey.shade300,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          genre,
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  webtoonContent.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_up_outlined,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.collections_bookmark_outlined,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
