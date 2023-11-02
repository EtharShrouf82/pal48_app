class CommentModel {
  final String comment, date;
  final String? name;
  CommentModel({
    required this.comment,
    required this.date,
    this.name,
  });
  factory CommentModel.fromJson(Map<String, dynamic> jsonRes) {
    return CommentModel(
      comment: jsonRes['comment'] as String,
      name: jsonRes['name'] as String?,
      date: jsonRes['created_at'] as String,
    );
  }
}
