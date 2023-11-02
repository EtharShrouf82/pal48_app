class PhotoModel {
  final String filename;
  final String? desc;
  final int id;
  final int type;
  PhotoModel({
    this.desc,
    required this.type,
    required this.filename,
    required this.id,
  });
  factory PhotoModel.fromJson(Map<String, dynamic> jsonRes) {
    return PhotoModel(
      filename: jsonRes['filename'] as String,
      desc: jsonRes['desc'] as String?,
      id: jsonRes['id'] as int,
      type: jsonRes['type'] as int,
    );
  }
}
