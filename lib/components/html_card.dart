import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:pal48/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlView extends StatelessWidget {
  final String? txt;

  const HtmlView({
    super.key,
    required this.txt,
  });

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
      onTapUrl: (url) async {
        if (!await launchUrl(Uri.parse(url))) {
          throw Exception('Could not launch $url');
        }
        return false;
      },

      // select the render mode for HTML body
      // by default, a simple `Column` is rendered
      // consider using `ListView` or `SliverList` for better performance
      renderMode: RenderMode.column,
    );
  }
}
