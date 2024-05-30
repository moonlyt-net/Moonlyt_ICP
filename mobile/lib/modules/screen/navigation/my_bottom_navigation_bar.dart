import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class MyBottomNavigationBar extends ConsumerWidget {
  final Widget child;
  const MyBottomNavigationBar({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    void onItemTapped(int index) {
      ref.read(selectedIndexProvider.notifier).state = index;
      String route = 'webtoon';
      if (index == 1) {
        route = 'moonpass';
      } else if (index == 2) {
        route = 'mymoonpass';
      } else if (index == 3) {
        route = 'my';
      }
      context.pushNamed(route);
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            child,
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.9),
                  border: const Border(
                    top: BorderSide(color: Colors.grey, width: 2.0),
                    bottom: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.auto_stories_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      label: 'Home',
                      activeIcon: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.auto_stories_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.sell_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      label: 'Settings',
                      activeIcon: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.sell_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.photo_library_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      label: 'Home',
                      activeIcon: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.photo_library_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      label: 'Settings',
                      activeIcon: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                  currentIndex: selectedIndex,
                  onTap: onItemTapped,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
