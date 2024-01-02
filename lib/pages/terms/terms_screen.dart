import 'package:pal48/Api/api.dart';
import 'package:pal48/components/html_card.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/exports/exports.dart';
import '../../constants/constants.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final privacy = Provider.of<ContactProvider>(context, listen: true);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: translation(context).terms,
          share: '${Api.url}/app',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              privacy.loadingTermsData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : HtmlView(txt: privacy.privaceData),
            ],
          ),
        ),
      ),
    );
  }
}
