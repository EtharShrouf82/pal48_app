import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String url) async {
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(
      url,
    );
  }
}
