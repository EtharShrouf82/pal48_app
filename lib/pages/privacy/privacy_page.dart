import 'package:clipboard/clipboard.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/html_card.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/exports/exports.dart';

import '../../constants/constants.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final privacy = Provider.of<ContactProvider>(context, listen: true);
    final token = Provider.of<DeviceTokensProvider>(context, listen: true);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: translation(context).privacyScreen,
          share: '${Api.url}/app',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              privacy.loadingPrivacy
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : HtmlView(txt: privacy.privaceData),
              const Divider(),
              InkWell(
                child: const SizedBox(
                  width: double.infinity,
                  height: 30.0,
                ),
                onDoubleTap: () {
                  FlutterClipboard.copy(token.deviceToken).then((value) {});
                  token.showDeviceTokenFunc();
                },
              ),
              token.showDeviceToken
                  ? Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(token.deviceToken),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
