import 'package:pal48/models/attachment_model.dart';
import 'package:pal48/models/photo_model.dart';

class ArticleModel {
  final int id;
  final String title;
  final String? follow;
  final String description;
  final String? img;
  final List<PhotoModel>? images;
  final List<AttachmentModel>? attachments;
  ArticleModel({
    required this.id,
    required this.title,
    this.follow,
    this.img,
    required this.description,
    this.images,
    this.attachments,
  });
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    List<PhotoModel> images = List<PhotoModel>.from(
      json['images'].map(
        (model) => PhotoModel.fromJson(model),
      ),
    );
    List<AttachmentModel> attachments = List<AttachmentModel>.from(
      json['attachments'].map(
        (model) => AttachmentModel.fromJson(model),
      ),
    );
    return ArticleModel(
      id: json['id'] as int,
      title: json['title'] as String,
      img: json['img'] as String?,
      follow: json['follow'] as String?,
      description: json['description'] as String,
      images: images,
      attachments: attachments,
    );
  }
}
