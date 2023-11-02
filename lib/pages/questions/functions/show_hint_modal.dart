import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal48/components/custom_modal_bottom_sheet.dart';
import 'package:pal48/components/html_card.dart';
import 'package:pal48/constants/constants.dart';

showHintModal(
  BuildContext context,
  String question,
  String txt,
) {
  return customModalBottomSheet(
    context,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: defaultPadding,
                      bottom: defaultPadding,
                    ),
                    child: Text(
                      question,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge!.fontSize,
                        shadows: const <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 5.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset('assets/svg/Close.svg'),
                  color: whiteColor,
                ),
              ],
            ),
          ),
          HtmlView(
            txt: txt,
          )
        ],
      ),
    ),
  );
}
