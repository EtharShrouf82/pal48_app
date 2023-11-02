import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/helpers/open_link.dart';

class SocialIcon extends StatelessWidget {
  final String url;
  final String icon;

  const SocialIcon({
    super.key,
    required this.url,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        openLink(url);
      },
      icon: SvgPicture.asset(
        icon,
        width: 24,
        colorFilter: ColorFilter.mode(
          Theme.of(context).textTheme.bodyLarge!.color!,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
