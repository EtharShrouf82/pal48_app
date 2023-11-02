import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';

class TextFormFieldUi extends StatelessWidget {
  final int validationNumber;
  final String validationMessage;
  final TextEditingController controller;
  final TextInputType textInputType;
  final IconData? prefixIcon;
  final int maxLines;
  final String? labelTxt;
  final String errorMsg;
  final TextAlign textAlign;
  final Color? filledColor;

  const TextFormFieldUi({
    Key? key,
    required this.validationNumber,
    required this.validationMessage,
    required this.controller,
    required this.textInputType,
    required this.prefixIcon,
    required this.maxLines,
    required this.labelTxt,
    required this.errorMsg,
    required this.textAlign,
    this.filledColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxLines * 44.0,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        style: kSubHeadTextStyle.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        validator: (val) =>
            val!.length < validationNumber ? validationMessage : null,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
          // labelStyle: TextStyle(
          //     color: Provider.of<ThemeProvider>(context).kYellowColor),
          filled: true,
          // fillColor:
          //     filledColor ?? Provider.of<ThemeProvider>(context).kBodyColor,
          prefixIcon: Icon(
            prefixIcon,
            // color: Provider.of<ThemeProvider>(context).kYellowColor,
          ),
          labelText: labelTxt,
          hintText: errorMsg,
        ),
      ),
    );
  }
}
