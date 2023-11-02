import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal48/components/banner_m.dart';
import 'package:pal48/constants/constants.dart';

class BannerMStyle2 extends StatelessWidget {
  const BannerMStyle2({
    Key? key,
    required this.image,
    required this.title,
    required this.press,
    this.subtitle,
  }) : super(key: key);
  final String image;
  final String title;
  final String? subtitle;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image,
      press: press,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    if (subtitle != null)
                      Text(
                        subtitle!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: defaultPadding),
              SizedBox(
                height: 48,
                width: 48,
                child: ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white,
                  ),
                  child: SvgPicture.asset(
                    "assets/svg/Arrow - Left.svg",
                    colorFilter:
                        const ColorFilter.mode(blackColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
