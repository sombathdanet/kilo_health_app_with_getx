class HomeGridModel {
  int id;
  String type;
  String name;
  String description;
  String thumbnail;
  bool favorite;
  String createdAt;

  HomeGridModel({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.favorite,
    required this.createdAt,
  });
}
