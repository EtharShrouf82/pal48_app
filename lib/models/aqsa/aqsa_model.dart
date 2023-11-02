class AqsaModel {
  final int id;
  final String title;
  final String? image;
  final String? description;
  AqsaModel({
    required this.id,
    required this.title,
    this.description,
    this.image,
  });
  factory AqsaModel.fromJson(Map<String, dynamic> json) {
    return AqsaModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );
  }
}
