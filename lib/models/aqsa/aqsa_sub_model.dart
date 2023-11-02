import 'package:pal48/models/photo_model.dart';

class AqsaSubModel {
  final int id;
  final String title;
  final String? image;
  final String? description;
  final List<PhotoModel>? images;
  AqsaSubModel({
    required this.id,
    required this.title,
    this.description,
    this.image,
    this.images,
  });
  factory AqsaSubModel.fromJson(Map<String, dynamic> json) {
    List<PhotoModel> images = List<PhotoModel>.from(
      json['images'].map(
        (model) => PhotoModel.fromJson(model),
      ),
    );
    return AqsaSubModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      images: images,
    );
  }
}
