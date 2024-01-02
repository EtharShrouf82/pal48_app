import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/exports/exports.dart';

class MultiCampSelect extends StatelessWidget {
  final List? initialValue;
  final dynamic onSaved;

  const MultiCampSelect({
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
      title: Text(
        translation(context).filterByCountry,
        style: const TextStyle(fontSize: 16),
      ),
      dataSource: [
        {
          "display": translation(context).palestine,
          "value": 1,
        },
        {
          "display": translation(context).jordan,
          "value": 2,
        },
        {
          "display": translation(context).syria,
          "value": 3,
        },
        {
          "display": translation(context).lebanon,
          "value": 4,
        }
      ],
      textField: 'display',
      valueField: 'value',
      okButtonLabel: translation(context).filter,
      cancelButtonLabel: translation(context).cancel,
      hintWidget: Text(translation(context).moreCountry),
      initialValue: initialValue,
      onSaved: onSaved,
    );
  }
}
