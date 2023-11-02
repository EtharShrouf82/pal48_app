import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class NetworkImageZoom extends StatelessWidget {
  final String img;

  const NetworkImageZoom({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Hero(
        tag: "zoom$img",
        child: Stack(
          children: [
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(128, 50, 52, 53)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PhotoViewGallery.builder(
                itemCount: 1,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(img),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromARGB(128, 82, 83, 84),
                ),
                enableRotation: false,
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              (event.expectedTotalBytes ?? 0),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 50,
                right: 30,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
