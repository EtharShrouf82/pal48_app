import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:pal48/constants/constants.dart';

class MultiCampSelect extends StatelessWidget {
  final List? initialValue;
  final dynamic onSaved;

  const MultiCampSelect({
    Key? key,
    required this.initialValue,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSelectFormField(
      autovalidate: AutovalidateMode.disabled,
      chipBackGroundColor: primaryColor,
      chipLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      checkBoxActiveColor: primaryColor,
      checkBoxCheckColor: primaryColor,
      dialogShapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      title: const Text(
        "تصنيف حسب الدولة",
        style: TextStyle(fontSize: 16),
      ),
      dataSource: const [
        {
          "display": "فلسطين",
          "value": 1,
        },
        {
          "display": "الأردن",
          "value": 2,
        },
        {
          "display": "سوريا",
          "value": 3,
        },
        {
          "display": "لبنان",
          "value": 4,
        }
      ],
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'فرز',
      cancelButtonLabel: 'إلغاء',
      hintWidget: const Text('بالإمكان إختيار أكثر من دولة'),
      initialValue: initialValue,
      onSaved: onSaved,
    );
  }
}
