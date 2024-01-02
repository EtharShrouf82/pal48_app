import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/helpers/open_link.dart';

class DownloadButton extends StatelessWidget {
  final String url;
  final String desc;

  const DownloadButton({super.key, required this.url, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: ElevatedButton(
        onPressed: () {
          openLink(url);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.picture_as_pdf,
                  size: 20,
                  color: whiteColor,
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                Text(
                  desc,
                  style: kSubHeadTextStyle.copyWith(color: whiteColor),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
