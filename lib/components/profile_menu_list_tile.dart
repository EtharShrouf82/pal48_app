import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/components/divider_list_tyle.dart';
import 'package:pal48/constants/constants.dart';

class ProfileMenuListTile extends StatelessWidget {
  const ProfileMenuListTile({
    super.key,
    required this.text,
    required this.svgSrc,
    required this.press,
    this.isShowDivider = true,
  });

  final String text, svgSrc;
  final VoidCallback press;
  final bool isShowDivider;

  @override
  Widget build(BuildContext context) {
    return DividerListTile(
      minLeadingWidth: 24,
      leading: SvgPicture.asset(
        svgSrc,
        height: 24,
        width: 24,
        colorFilter: ColorFilter.mode(
          Theme.of(context).textTheme.bodyLarge!.color!,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        text,
        style: kSubHeadTextStyle.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
      press: press,
      isShowDivider: isShowDivider,
    );
  }
}
