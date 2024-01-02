class GazaModel {
  final int id, type;
  final String link, description;
  final String? inDate;
  GazaModel({
    required this.id,
    required this.type,
    required this.link,
    this.inDate,
    required this.description,
  });
  factory GazaModel.fromJson(Map<String, dynamic> json) {
    return GazaModel(
      id: json['id'] as int,
      type: json['type'] as int,
      link: json['link'] as String,
      inDate: json['in_date'] as String?,
      description: json['description'] as String,
    );
  }
}
