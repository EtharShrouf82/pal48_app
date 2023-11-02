class MediaModel {
  final int id;
  final int? imageableId;
  final String? description;
  final String filename;
  MediaModel({
    required this.id,
    this.imageableId,
    required this.filename,
    this.description,
  });
  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'] as int,
      imageableId: json['imageable_id'] as int?,
      filename: json['filename'] as String,
      description: json['description'] as String?,
    );
  }
}
