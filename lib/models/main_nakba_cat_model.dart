class MainNakbaCatModel {
  final int id;
  final String title, img;
  final String? description;
  MainNakbaCatModel({
    required this.id,
    required this.title,
    required this.img,
    this.description,
  });
  factory MainNakbaCatModel.fromJson(Map<String, dynamic> json) {
    return MainNakbaCatModel(
      id: json['id'] as int,
      title: json['title'] as String,
      img: json['img'] as String,
      description: json['description'] as String?,
    );
  }
}
