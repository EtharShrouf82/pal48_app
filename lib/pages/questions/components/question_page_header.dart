import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';

class QuestionPageHeader extends StatelessWidget {
  final String title;

  const QuestionPageHeader({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: defaultPadding,
            right: defaultPadding,
            left: defaultPadding,
            bottom: 40.0,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall!.fontSize,
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
            ],
          ),
        ),
      ),
    );
  }
}
