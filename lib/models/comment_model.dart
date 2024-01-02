class CommentModel {
  final String comment, date, updatedAt;
  final String? name, reply;
  CommentModel({
    required this.comment,
    required this.date,
    required this.updatedAt,
    this.name,
    this.reply,
  });
  factory CommentModel.fromJson(Map<String, dynamic> jsonRes) {
    return CommentModel(
      comment: jsonRes['comment'] as String,
      reply: jsonRes['reply'] as String?,
      name: jsonRes['name'] as String?,
      date: jsonRes['created_at'] as String,
      updatedAt: jsonRes['updated_at'] as String,
    );
  }
}
