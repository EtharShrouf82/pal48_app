import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/constants/constants.dart';

class NavItems extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  final Color iconColor;

  const NavItems({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding),
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
            iconColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
