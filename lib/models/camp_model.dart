import 'package:pal48/models/photo_model.dart';

class CampModel {
  final int id;
  final String title;
  final String? desc, img, country, city, result;
  final List<PhotoModel>? images;
  CampModel({
    required this.id,
    required this.title,
    this.img,
    this.desc,
    this.images,
    this.country,
    this.city,
    this.result,
  });
  factory CampModel.fromJson(Map<String, dynamic> jsonRes) {
    List<PhotoModel> images = List<PhotoModel>.from(
      jsonRes['images'].map(
        (model) => PhotoModel.fromJson(model),
      ),
    );

    return CampModel(
      id: jsonRes['id'] as int,
      title: jsonRes['title'] as String,
      img: jsonRes['img'] as String?,
      desc: jsonRes['description'] as String?,
      country: jsonRes['country'] as String?,
      city: jsonRes['city'] as String?,
      result: jsonRes['result'] as String?,
      images: images,
    );
  }
}
