import 'package:pal48/models/photo_model.dart';

class MasscareModel {
  final int id;
  final String title, desc;
  final String? result, inDate, img;
  final List<PhotoModel>? images;
  MasscareModel({
    required this.id,
    required this.title,
    required this.desc,
    this.images,
    this.result,
    this.inDate,
    this.img,
  });
  factory MasscareModel.fromJson(Map<String, dynamic> jsonRes) {
    List<PhotoModel> images = List<PhotoModel>.from(
      jsonRes['images'].map(
        (model) => PhotoModel.fromJson(model),
      ),
    );

    return MasscareModel(
      id: jsonRes['id'] as int,
      title: jsonRes['title'] as String,
      img: jsonRes['img'] as String?,
      desc: jsonRes['description'] as String,
      inDate: jsonRes['in_date'] as String?,
      result: jsonRes['result'] as String?,
      images: images,
    );
  }
}
