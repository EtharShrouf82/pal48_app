import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/components/title_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/helpers/get_locale.dart';
import 'package:pal48/helpers/open_link.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:provider/provider.dart';

class AqsaPage extends StatelessWidget {
  const AqsaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final aqsaProvider = Provider.of<AqsaProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: translation(context).alaqsa,
          share: '${Api.url}/aqsa',
        ),
      ),
      body: SafeArea(
        child: aqsaProvider.dataLoaded
            ? CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(defaultPadding),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          translation(context).alaqsaShahed,
                          style: kHeadingTextStyle.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(defaultPadding),
                    sliver: SliverToBoxAdapter(
                        child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: aqsaProvider.aqsaModel.map((e) {
                        return TitleCard(
                          id: e.id,
                          title: e.title,
                          description: e.description,
                          goToPage: 'aqsa_details',
                        );
                      }).toList(), // all the children is making an error
                    )),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(defaultPadding),
                    sliver: SliverToBoxAdapter(
                      child: OutlinedButton(
                        onPressed: () {
                          openLink('${Api.url}/interact');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/aqsa_svg.svg'),
                            Text(translation(context).alaqsaInteractive)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
      ),
    );
  }
}
