import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoom extends StatelessWidget {
  final String img;

  const ImageZoom({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Hero(
        tag: "zoom$img",
        child: Stack(
          children: [
            PhotoView(
              imageProvider: AssetImage(img),
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
