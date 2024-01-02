import 'package:pal48/models/attachment_model.dart';
import 'package:pal48/models/photo_model.dart';

class PlaceModel {
  final int id;
  final String title, desc, img, city;
  final List<PhotoModel>? images;
  final List<AttachmentModel>? attachments;
  PlaceModel({
    required this.id,
    required this.title,
    required this.img,
    required this.desc,
    this.images,
    this.attachments,
    required this.city,
  });
  factory PlaceModel.fromJson(Map<String, dynamic> jsonRes) {
    List<PhotoModel> images = List<PhotoModel>.from(
      jsonRes['images'].map(
        (model) => PhotoModel.fromJson(model),
      ),
    );
    List<AttachmentModel> attachments = List<AttachmentModel>.from(
      jsonRes['attachments'].map(
        (model) => AttachmentModel.fromJson(model),
      ),
    );

    return PlaceModel(
      id: jsonRes['id'] as int,
      title: jsonRes['title'] as String,
      img: jsonRes['img'] as String,
      desc: jsonRes['description'] as String,
      city: jsonRes['city'] as String,
      images: images,
      attachments: attachments,
    );
  }
}
