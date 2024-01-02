import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pal48/Api/api.dart';
import 'package:pal48/components/massacre_card.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/exports/exports.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MassacrePage extends StatelessWidget {
  const MassacrePage({super.key});
  @override
  Widget build(BuildContext context) {
    final massacreProvider = Provider.of<MasscareProvider>(context);
    onMassacreRefresh() {
      massacreProvider.onMassacreRefresh();
    }

    onMassacreLoading() {
      massacreProvider.onMassacreLoading();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: translation(context).zionestMassacres,
          share: '${Api.url}/massacres',
          search: true,
          follow: 2,
        ),
      ),
      body: SafeArea(
        child: massacreProvider.masscareModel.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Expanded(
                      child: AnimationLimiter(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          controller:
                              massacreProvider.refreshMassacreController,
                          onRefresh: onMassacreRefresh,
                          onLoading: onMassacreLoading,
                          physics: const BouncingScrollPhysics(),
                          header: const WaterDropHeader(
                            waterDropColor: Colors.red,
                          ),
                          footer: const ClassicFooter(
                              loadStyle: LoadStyle.ShowWhenLoading),
                          child: ListView.builder(
                              itemCount: massacreProvider.masscareModel.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: MassacreCard(
                                        masscareModel: massacreProvider
                                            .masscareModel[index],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
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
