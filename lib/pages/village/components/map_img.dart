import 'package:flutter/material.dart';
import 'package:pal48/components/image_zoom.dart';

class MapImg extends StatelessWidget {
  final String img;

  const MapImg({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return ImageZoom(
                  img: img,
                );
              },
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> curvedAnimation,
                  Widget child) {
                return Align(
                  child: SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 200),
            ),
          );
        },
        child: Image.asset(img),
      ),
    );
  }
}
