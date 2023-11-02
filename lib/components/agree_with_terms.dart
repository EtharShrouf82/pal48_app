import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';
import 'package:provider/provider.dart';

import '../providers/contact_us_provider.dart';

class AgreeWithTerms extends StatelessWidget {
  const AgreeWithTerms({super.key});

  @override
  Widget build(BuildContext context) {
    final contactProvider =
        Provider.of<ContactProvider>(context, listen: false);
    return Row(
      children: [
        Text.rich(
          TextSpan(
            text: "أوافق على",
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    contactProvider.privaceData.isEmpty
                        ? contactProvider.getTermsData()
                        : null;
                    Navigator.pushNamed(context, '/terms');
                  },
                text: " سياسة الإستخدام ",
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const TextSpan(
                text: "و سياسة الخصوصية.",
              ),
            ],
          ),
        )
      ],
    );
  }
}
