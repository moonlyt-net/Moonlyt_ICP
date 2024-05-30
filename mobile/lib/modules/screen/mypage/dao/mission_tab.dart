import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlyt/modules/model/my_pass.dart';

import '../my_moonpass_view_model.dart';

final isStarredProvider = StateProvider<Map<int, bool>>((ref) => {});

class MissionTab extends ConsumerWidget {
  const MissionTab({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStarredMap = ref.watch(isStarredProvider);
    final myMissions = ref
        .watch(myPassListProvider)
        .firstWhere(
          (element) => element.title == title,
        )
        .missions;
    return SizedBox(
      child: ListView.builder(
        itemCount: myMissions.length,
        itemBuilder: (context, index) {
          final mission = myMissions[index];
          ref.watch(isStarredProvider).putIfAbsent(index, () => false);
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(mission.content,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(mission.point.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ref
                        .read(isStarredProvider.notifier)
                        .update((state) => {...state, index: true});
                  },
                  icon: Icon(
                    Icons.verified,
                    color: isStarredMap[index]! ? Colors.blue : Colors.white,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
