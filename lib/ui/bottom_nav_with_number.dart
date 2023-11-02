import 'package:flutter/material.dart';

class BottomNavWithNumber extends StatelessWidget {
  final String count;

  const BottomNavWithNumber({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -7.0,
      right: -0.5,
      child: Container(
        padding: const EdgeInsets.only(
          top: 5.0,
          right: 5.0,
          left: 5.0,
          bottom: 10.0,
        ),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: Center(
          child: Text(
            count,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
