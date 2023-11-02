class SubNakbaCatModel {
  final int id;
  final String title;
  final String? description;
  SubNakbaCatModel({
    required this.id,
    required this.title,
    this.description,
  });
  factory SubNakbaCatModel.fromJson(Map<String, dynamic> json) {
    return SubNakbaCatModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
    );
  }
}
