import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlyt/modules/screen/mypage/dao/mission_tab.dart';
import 'package:moonlyt/modules/screen/mypage/dao/vote_tab.dart';
import 'package:moonlyt/modules/screen/mypage/my_moonpass_view_model.dart';

class DaoView extends ConsumerStatefulWidget {
  const DaoView({required this.title, super.key});
  final String title;

  @override
  ConsumerState<DaoView> createState() => _DaoViewState();
}

class _DaoViewState extends ConsumerState<DaoView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _askingTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Tab> _askingTabs = <Tab>[
    Tab(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: const Text(
          'Missions',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    ),
    Tab(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: const Text(
          'Votes',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pass = ref.watch(myPassListProvider).firstWhere(
          (element) => element.title == widget.title,
        );
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/background_dark.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  height: 60,
                  child: Row(
                    children: [
                      TabBar(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        tabs: _askingTabs,
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white.withOpacity(0.75),
                        controller: _tabController,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      MissionTab(title: widget.title),
                      VoteTab(title: widget.title),
                      // const VoteTab(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
