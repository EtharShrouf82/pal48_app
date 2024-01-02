class AttachmentModel {
  final String filename;
  final String? desc;
  final int id;
  AttachmentModel({
    this.desc,
    required this.filename,
    required this.id,
  });
  factory AttachmentModel.fromJson(Map<String, dynamic> jsonRes) {
    return AttachmentModel(
      filename: jsonRes['filename'] as String,
      desc: jsonRes['desc'] as String?,
      id: jsonRes['id'] as int,
    );
  }
}
