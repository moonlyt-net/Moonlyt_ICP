import 'package:moonlyt/modules/model/webtoon.dart';

class WebtoonContent {
  final String id;
  final String title;
  final List<String> genres;
  final List<Webtoon> comics;
  final String imagePath;
  final String address;

  WebtoonContent({
    required this.id,
    required this.title,
    required this.genres,
    required this.comics,
    required this.imagePath,
    required this.address,
  });

  factory WebtoonContent.fromJson(Map<String, dynamic> json) {
    List<String> genresFromJson = List<String>.from(json['genres']);
    List<Webtoon> comicsFromJson = (json['comics'] as List)
        .map((comicJson) => Webtoon.fromJson(comicJson))
        .toList();

    return WebtoonContent(
      id: json['id'],
      title: json['title'],
      genres: genresFromJson,
      comics: comicsFromJson,
      imagePath: json['imagePath'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genres': genres,
      'imagePath': imagePath,
      'comics': comics.map((comic) => comic.toJson()).toList(),
      'address': address,
    };
  }
}

List<WebtoonContent> webtoonContents = [
  webtoonContent1,
  webtoonContent2,
  webtoonContent3,
  webtoonContent4,
  webtoonContent5,
  webtoonContent6,
];

WebtoonContent webtoonContent1 = WebtoonContent(
  id: "1",
  title: "Starlight",
  genres: ["Action", "Fantasy", "Sci-Fi"],
  comics: [comic1, comic2],
  imagePath: "assets/starlight.png",
  address: "9607f5df7daac5c406919242119d58d6227d3b7e905942d149e744a0ba9e3647",
);

WebtoonContent webtoonContent2 = WebtoonContent(
  id: "2",
  title: "Wizard's end",
  genres: ["Drama", "Fantasy", "Magic"],
  comics: [comic1, comic2],
  imagePath: "assets/wizards_end.png",
  address: "0d8916bff60ec9bdc5841a228c33feaea1a173b8c20b0589bbb00b35156f212e",
);

WebtoonContent webtoonContent3 = WebtoonContent(
  id: "3",
  title: "The Last Mage",
  genres: ["Adventure", "Magic"],
  comics: [comic1, comic2],
  imagePath: "assets/last_mage.png",
  address: "5f395f70b2cb3ee56e76acd3d4f8ccb5988d1bfa0ab8d1292ad1a37742a09370",
);

WebtoonContent webtoonContent4 = WebtoonContent(
  id: "4",
  title: "cowboy james",
  genres: ["Space", "Adventure"],
  comics: [comic1, comic2],
  imagePath: "assets/cowboy.png",
  address: "39a64680fe6796b68214154d5a24fd8b782b294b186e329a48bd448792817f2d",
);

WebtoonContent webtoonContent5 = WebtoonContent(
  id: "5",
  title: "Born to dragon parents",
  genres: ["Fantasy", "Magic", "Adventure"],
  comics: [comic1, comic2],
  imagePath: "assets/dragon.png",
  address: "581bc5a26460128b6f2bf815dd18160c69e48f2341cb895bc60b7653d2f58c82",
);

WebtoonContent webtoonContent6 = WebtoonContent(
  id: "6",
  title: "Our school days",
  genres: ["drama", "romance"],
  comics: [comic1, comic2],
  imagePath: "assets/school.png",
  address: "ee0dc92431a2f74c4b25fce66c53a5d0a96cd77bfe6b49e7f97389673246d5dd",
);

Webtoon comic1 = Webtoon(
  id: "1",
  title: "lost memroy",
  imagePaths: [
    "assets/part1.png",
    "assets/part2.png",
  ],
  date: "2024-04-07",
  price: 0,
);

Webtoon comic2 = Webtoon(
  id: "2",
  title: "hero is back",
  imagePaths: [
    "assets/part2.png",
    "assets/part1.png",
  ],
  date: "2024-04-02",
  price: 2000,
);
