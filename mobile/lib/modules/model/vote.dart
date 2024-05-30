class Vote {
  DateTime startDate;
  DateTime endDate;
  String title;
  int eligibleVoters;
  int agreeVotes;
  int disagreeVotes;

  Vote({
    required this.startDate,
    required this.endDate,
    required this.title,
    required this.eligibleVoters,
    required this.agreeVotes,
    required this.disagreeVotes,
  });

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      title: json['title'],
      eligibleVoters: json['eligibleVoters'],
      agreeVotes: json['agreeVotes'],
      disagreeVotes: json['disagreeVotes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'title': title,
      'eligibleVoters': eligibleVoters,
      'agreeVotes': agreeVotes,
      'disagreeVotes': disagreeVotes,
    };
  }
}
