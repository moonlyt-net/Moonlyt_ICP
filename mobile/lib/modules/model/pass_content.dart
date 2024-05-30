import 'package:moonlyt/modules/model/mission.dart';

class Content {
  final String title;
  final List<String> genres;
  final String preview;
  final int price;
  final List<Mission> missions;
  final List<String> benefits;
  final String thumbnail;
  final int maxIssuance; // 최대 발행 수량 추가
  final int currentPurchases; // 현재 구입 수량 추가

  Content({
    required this.title,
    required this.genres,
    required this.preview,
    required this.price,
    required this.missions,
    required this.benefits,
    required this.thumbnail,
    required this.maxIssuance, // 생성자에 추가
    required this.currentPurchases, // 생성자에 추가
  });

  Content copyWith({
    String? title,
    List<String>? genres,
    String? preview,
    List<Mission>? missions,
    List<String>? benefits,
    int? price,
    String? thumbnail,
    int? maxIssuance,
    int? currentPurchases,
  }) {
    return Content(
      title: title ?? this.title,
      genres: genres ?? this.genres,
      preview: preview ?? this.preview,
      missions: missions ?? this.missions,
      benefits: benefits ?? this.benefits,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      maxIssuance: maxIssuance ?? this.maxIssuance,
      currentPurchases: currentPurchases ?? this.currentPurchases,
    );
  }

  factory Content.fromJson(Map<String, dynamic> json) {
    List<String> genresFromJson = List<String>.from(json['genres']);
    List<Mission> missionsFromJson = (json['missions'] as List)
        .map((missionJson) => Mission.fromJson(missionJson))
        .toList();
    List<String> benefitsFromJson = List<String>.from(json['benefits']);

    return Content(
      title: json['title'],
      genres: genresFromJson,
      preview: json['preview'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      missions: missionsFromJson,
      benefits: benefitsFromJson,
      maxIssuance: json['maxIssuance'], // JSON에서 읽어오기
      currentPurchases: json['currentPurchases'], // JSON에서 읽어오기
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'genres': genres,
      'preview': preview,
      'price': price,
      'missions': missions.map((mission) => mission.toJson()).toList(),
      'benefits': benefits,
      'thumbnail': thumbnail,
      'maxIssuance': maxIssuance, // JSON으로 변환
      'currentPurchases': currentPurchases, // JSON으로 변환
    };
  }
}

List<Content> contents = [
  Content(
    thumbnail: "assets/starlight.png",
    title: "Starlight",
    genres: ["Action", "Fantasy", "Sci-Fi"],
    preview: "Preview text for Webtoon A.",
    price: 2000,
    maxIssuance: 10,
    currentPurchases: 9,
    missions: [
      Mission(content: "twitter follow mission", point: 10),
      Mission(content: "Share on social media", point: 5),
    ],
    benefits: ["NFT", "Exclusive access"],
  ),
  Content(
    thumbnail: "assets/wizards_end.png",
    title: "Wizard's end",
    genres: ["Drama", "Fantasy", "Magic"],
    preview: "Adventure awaits in Webtoon B.",
    price: 2000,
    maxIssuance: 200,
    currentPurchases: 75,
    missions: [
      Mission(content: "Complete the survey", point: 20),
      Mission(content: "Refer a friend", point: 15),
    ],
    benefits: ["Early bird discount", "Special edition NFT"],
  ),
  Content(
    thumbnail: "assets/last_mage.png",
    title: "The Last Mage",
    genres: ["Adventure", "Magic"],
    preview: "Laugh out loud with Webtoon C.",
    price: 1500,
    maxIssuance: 150,
    currentPurchases: 100,
    missions: [
      Mission(content: "Watch the first episode", point: 5),
      Mission(content: "Subscribe to the series", point: 10),
    ],
    benefits: ["Access to exclusive episodes", "Behind the scenes content"],
  ),
  Content(
    thumbnail: "assets/cowboy.png",
    title: "cowboy james",
    genres: ["Space", "Adventure"],
    preview: "Explore the future with Webtoon D.",
    price: 2500,
    maxIssuance: 80,
    currentPurchases: 32,
    missions: [
      Mission(content: "Post a review", point: 25),
      Mission(content: "Join the fan club", point: 20),
    ],
    benefits: ["Signed artwork", "VIP meetup invites"],
  ),
  Content(
    thumbnail: "assets/dragon.png",
    title: "Born to dragon parents",
    genres: ["Fantasy", "Magic", "Adventure"],
    preview: "Feel the thrill of Webtoon E.",
    price: 1800,
    maxIssuance: 120,
    currentPurchases: 60,
    missions: [
      Mission(content: "Share a scare", point: 10),
      Mission(content: "Follow the creator", point: 15),
    ],
    benefits: ["Exclusive merchandise", "Early access to new episodes"],
  ),
];
