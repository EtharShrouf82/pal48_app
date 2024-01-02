import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:pal48/constants/constants.dart';

class MultiSelect extends StatelessWidget {
  final List? initialValue;
  final dynamic onSaved;

  const MultiSelect({
    super.key,
    required this.initialValue,
    required this.onSaved,
  });

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
        "تصنيف حسب المدينة",
        style: TextStyle(fontSize: 16),
      ),
      dataSource: const [
        {
          "display": "القدس",
          "value": "11",
        },
        {
          "display": "صفد",
          "value": "1",
        },
        {
          "display": "عكا",
          "value": "3",
        },
        {
          "display": "طبريا",
          "value": "5",
        },
        {
          "display": "الناصرة",
          "value": "2",
        },
        {
          "display": "بيسان",
          "value": "7",
        },
        {
          "display": "حيفا",
          "value": "6",
        },
        {
          "display": "طوباس",
          "value": "17",
        },
        {
          "display": "نابلس",
          "value": "18",
        },
        {
          "display": "طولكرم",
          "value": "9",
        },
        {
          "display": "قلقيلية",
          "value": "19",
        },
        {
          "display": "يافا",
          "value": "10",
        },
        {
          "display": "الرملة",
          "value": "4",
        },
        {
          "display": "اللد",
          "value": "20",
        },
        {
          "display": "رام اللة",
          "value": "21",
        },
        {
          "display": "أريحا",
          "value": "16",
        },
        {
          "display": "بيت لحم",
          "value": "15",
        },
        {
          "display": "الخليل",
          "value": "12",
        },
        {
          "display": "غزة",
          "value": "13",
        },
        {
          "display": "بئر السبع",
          "value": "14",
        },
      ],
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'فرز',
      cancelButtonLabel: 'إلغاء',
      hintWidget: const Text('بالإمكان إختيار أكثر من مدينة'),
      initialValue: initialValue,
      onSaved: onSaved,
    );
  }
}
