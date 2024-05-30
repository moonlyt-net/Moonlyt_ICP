class Webtoon {
  final String title;
  final List<String> imagePaths;
  final String date;
  final int price;
  final String id;

  Webtoon({
    required this.title,
    required this.imagePaths,
    required this.date,
    required this.price,
    required this.id,
  });

  factory Webtoon.fromJson(Map<String, dynamic> json) {
    return Webtoon(
      title: json['title'],
      imagePaths: List<String>.from(json['imagePaths']),
      date: json['date'],
      price: json['price'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imagePaths': imagePaths,
      'date': date,
      'price': price,
      'id': id,
    };
  }
}
