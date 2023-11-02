import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';

class InfoLineContainer extends StatelessWidget {
  final String text;

  const InfoLineContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: defaultPadding / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyMedium?.color!.withOpacity(0.2),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!),
      ),
    );
  }
}
