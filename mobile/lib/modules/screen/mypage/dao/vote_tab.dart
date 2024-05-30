import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moonlyt/modules/model/vote.dart';
import 'package:moonlyt/modules/screen/mypage/my_moonpass_view_model.dart';
import 'package:moonlyt/modules/wallet/transaction_view_model.dart';

class VoteTab extends ConsumerStatefulWidget {
  const VoteTab({required this.title, super.key});
  final String title;

  @override
  ConsumerState<VoteTab> createState() => _VoteTabState();
}

class _VoteTabState extends ConsumerState<VoteTab> {
  Map<String, bool> userVotes = {};

  @override
  Widget build(BuildContext context) {
    final votes = ref
        .watch(myPassListProvider)
        .firstWhere(
          (element) => element.title == widget.title,
        )
        .votes;
    return SizedBox(
      child: ListView.builder(
        itemCount: votes.length,
        itemBuilder: (context, index) {
          return VoteListItem(
            vote: votes[index],
            onVote: (Vote vote, bool agree) {
              setState(() {
                final key = vote.title;
                userVotes[key] = true;
                if (agree) {
                  vote.agreeVotes += 1;
                } else {
                  vote.disagreeVotes += 1;
                }
              });
            },
            hasVoted: userVotes.containsKey(votes[index].title),
          );
        },
      ),
    );
  }
}

class VoteListItem extends ConsumerWidget {
  final Vote vote;
  final bool hasVoted;
  final Function(Vote, bool)? onVote;

  const VoteListItem({
    super.key,
    required this.vote,
    this.onVote,
    required this.hasVoted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isVoteEnded = DateTime.now().isAfter(vote.endDate);
    final dataFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.2),
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vote.title,
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            "Voting Period: ${dataFormat.format(vote.startDate)} ~ ${dataFormat.format(vote.endDate)}",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          buildProgressIndicator(vote, context),
          const SizedBox(height: 20),
          if (!isVoteEnded && !hasVoted) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    ref
                        .read(transactionRecordsProvider.notifier)
                        .addTransactionRecord(
                            DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            0,
                            'Vote');
                    onVote?.call(vote, true);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Text(
                      'Agree',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => onVote?.call(vote, true),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Text(
                      'Disagree',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else if (!isVoteEnded && hasVoted) ...[
            const Text("vote completed", style: TextStyle(color: Colors.white)),
          ] else ...[
            const Text("투표 종료",
                style: TextStyle(color: Colors.grey)), // 투표 종료 표시
          ]
        ],
      ),
    );
  }
}

Widget buildProgressIndicator(Vote vote, BuildContext context) {
  int totalVotes = vote.agreeVotes + vote.disagreeVotes;
  double agreeRatio = vote.agreeVotes / totalVotes;
  double disagreeRatio = vote.disagreeVotes / totalVotes;

  if (DateTime.now().isAfter(vote.endDate) ||
      vote.disagreeVotes + vote.agreeVotes == vote.eligibleVoters) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: (agreeRatio * 100).toInt(),
              child: Container(height: 20, color: Colors.blue.withOpacity(0.5)),
            ),
            Expanded(
              flex: (disagreeRatio * 100).toInt(),
              child: Container(height: 20, color: Colors.red.withOpacity(0.5)),
            ),
          ],
        ),
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "${(agreeRatio * 100).toStringAsFixed(1)}%",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  "${(disagreeRatio * 100).toStringAsFixed(1)}%",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  } else {
    // 투표 진행 중
    double progress = totalVotes / vote.eligibleVoters;
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(2),
      width: MediaQuery.of(context).size.width,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey[200], // 배경색
        borderRadius: BorderRadius.circular(5),
      ),
      child: FractionallySizedBox(
        widthFactor: progress,
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6C2D).withOpacity(0.3), Color(0xFFFFD53E)],
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
