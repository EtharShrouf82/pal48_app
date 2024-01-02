class TagModel {
  final int id, count;
  final String tag;
  TagModel({
    required this.id,
    required this.count,
    required this.tag,
  });
  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] as int,
      count: json['count'] as int,
      tag: json['tag'] as String,
    );
  }
}
