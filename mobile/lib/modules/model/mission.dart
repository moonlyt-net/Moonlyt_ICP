class Mission {
  final String content;
  final int point;

  Mission({required this.content, required this.point});

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      content: json['content'],
      point: json['point'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'point': point,
    };
  }
}
