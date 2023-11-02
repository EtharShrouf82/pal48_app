import 'package:pal48/models/photo_model.dart';

class VillageModel {
  final int id;
  final String title, desc, img;
  final String? inDate;
  final List<PhotoModel>? images;
  final String? latitude;
  final String? longitude;
  VillageModel({
    required this.id,
    required this.title,
    required this.img,
    required this.desc,
    this.images,
    this.inDate,
    this.latitude,
    this.longitude,
  });
  factory VillageModel.fromJson(Map<String, dynamic> jsonRes) {
    List<PhotoModel> images = List<PhotoModel>.from(
      jsonRes['images'].map(
        (model) => PhotoModel.fromJson(model),
      ),
    );

    return VillageModel(
      id: jsonRes['id'] as int,
      title: jsonRes['title'] as String,
      img: jsonRes['img'] as String,
      desc: jsonRes['description'] as String,
      inDate: jsonRes['in_date'] as String?,
      latitude: jsonRes['latitude'] as String?,
      longitude: jsonRes['longitude'] as String?,
      images: images,
    );
  }
}
