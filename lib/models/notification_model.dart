class NotificationModel {
  final String title;
  final int? pageId;
  final String follow;
  final String time;
  NotificationModel({
    required this.title,
    required this.follow,
    required this.time,
    this.pageId,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> jsonRes) {
    return NotificationModel(
      title: jsonRes['title'] as String,
      follow: jsonRes['follow'] as String,
      time: jsonRes['created_at'] as String,
      pageId: jsonRes['page_id'] as int?,
    );
  }
}
