import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlyt/modules/model/mission.dart';
import 'package:moonlyt/modules/model/my_pass.dart';
import 'package:moonlyt/modules/model/pass_content.dart';
import 'package:moonlyt/modules/model/vote.dart';

class MyPassListStateNotifier extends StateNotifier<List<MyPass>> {
  MyPassListStateNotifier() : super([]);

  // Adds a new pass with the given title to the list
  void addPassList(String title, List<Mission> missions, String thumbnail,
      List<String> benefits) {
    final newPass = MyPass(
      thumbnail: thumbnail,
      title: title,
      missions: missions,
      benefits: benefits,
      votes: [
        Vote(
          startDate: DateTime.now().subtract(const Duration(days: 10)),
          endDate: DateTime.now().add(const Duration(days: 10)),
          title: "Payment of funds to authors",
          eligibleVoters: 10,
          agreeVotes: 5,
          disagreeVotes: 4,
        ),
      ],
    );

    state = [...state, newPass];
  }
}

final myPassListProvider =
    StateNotifierProvider<MyPassListStateNotifier, List<MyPass>>((ref) {
  return MyPassListStateNotifier();
});
