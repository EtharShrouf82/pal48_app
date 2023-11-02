import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/components/network_image_zoom.dart';
import 'package:pal48/constants/constants.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final BoxFit fit;
  final String src;
  final double radius;
  final bool zoom;

  const NetworkImageWithLoader(
    this.src, {
    Key? key,
    this.fit = BoxFit.cover,
    this.zoom = false,
    this.radius = defaultPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Stack(
        children: [
          CachedNetworkImage(
            fit: fit,
            imageUrl: src,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          zoom
              ? Align(
                  alignment: AlignmentDirectional.bottomStart, // <-- SEE HERE
                  child: Container(
                    margin: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: blackColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(defaultPadding),
                    ),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/svg/fullscreen.svg',
                        colorFilter: const ColorFilter.mode(
                          whiteColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return NetworkImageZoom(
                                img: src,
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
                            transitionDuration:
                                const Duration(milliseconds: 200),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox(),
          // Positioned(
          //   height: 20,
          //   bottom: 24,
          //   left: 20,

          // )
        ],
      ),
    );
  }
}
