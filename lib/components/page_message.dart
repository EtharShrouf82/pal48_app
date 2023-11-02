import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';

class PageMessage extends StatelessWidget {
  final String txt;

  const PageMessage({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        boxShadow: [kDefaultShadow],
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color!,
          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize! * 1.1,
          shadows: const <Shadow>[
            Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 5.0,
              color: Color.fromARGB(255, 0, 0, 0),
            )
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
