import 'package:flutter/gestures.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/exports/exports.dart';

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
            text: translation(context).iAgree,
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    contactProvider.privaceData.isEmpty
                        ? contactProvider.getTermsData()
                        : null;
                    Navigator.pushNamed(context, '/terms');
                  },
                text: ' ${translation(context).terms} - ',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: ' ${translation(context).privacyScreen} .',
              ),
            ],
          ),
        )
      ],
    );
  }
}
