import 'package:pal48/models/photo_model.dart';

class EventModel {
  final int id, type;
  final String title, inDate, description;
  final String? img, city;
  final List<PhotoModel>? images;
  EventModel({
    required this.id,
    required this.title,
    required this.inDate,
    required this.type,
    this.img,
    this.city,
    required this.description,
    this.images,
  });
  factory EventModel.fromJson(Map<String, dynamic> json) {
    List<PhotoModel> images = List<PhotoModel>.from(
      json['images'].map(
        (model) => PhotoModel.fromJson(model),
      ),
    );
    return EventModel(
      id: json['id'] as int,
      title: json['title'] as String,
      inDate: json['in_date'] as String,
      type: json['type'] as int,
      img: json['img'] as String?,
      city: json['city'] as String?,
      description: json['description'] as String,
      images: images,
    );
  }
}
