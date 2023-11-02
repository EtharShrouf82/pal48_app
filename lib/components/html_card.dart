import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pal48/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HtmlView extends StatelessWidget {
  final String? txt;

  const HtmlView({
    Key? key,
    required this.txt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      // the first parameter (`html`) is required
      '''
$txt
  ''',
      textStyle: TextStyle(
        fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize! * 1.2,
        color: Provider.of<AppThemeProvider>(context).kgrayColor,
      ),
    );
  }
}
