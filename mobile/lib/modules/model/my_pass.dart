import 'package:moonlyt/modules/model/mission.dart';
import 'package:moonlyt/modules/model/vote.dart';

class MyPass {
  final String title;
  final String thumbnail;
  final List<String> benefits;
  final List<Vote> votes;
  final List<Mission> missions;

  MyPass({
    required this.title,
    required this.thumbnail,
    required this.benefits,
    required this.votes,
    required this.missions,
  });

  factory MyPass.fromJson(Map<String, dynamic> json) {
    List<Vote> votesList = (json['votes'] as List)
        .map((voteJson) => Vote.fromJson(voteJson))
        .toList();

    List<Mission> missionsList = (json['missions'] as List)
        .map((missionJson) => Mission.fromJson(missionJson))
        .toList();

    return MyPass(
      title: json['title'],
      thumbnail: json['thumbnail'],
      benefits: List<String>.from(json['benefits']),
      votes: votesList,
      missions: missionsList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> votesJsonList =
        votes.map((vote) => vote.toJson()).toList();
    List<Map<String, dynamic>> missionsJsonList =
        missions.map((mission) => mission.toJson()).toList();

    return {
      'title': title,
      'thumbnail': thumbnail,
      'benefits': benefits,
      'votes': votesJsonList,
      'missions': missionsJsonList,
    };
  }
}
