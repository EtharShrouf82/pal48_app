import 'package:pal48/components/square_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/exports/exports.dart';

class NakbaPage extends StatelessWidget {
  const NakbaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nakbaProvider = Provider.of<NakbaProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        translation(context).palestinianNakba,
        style: kHeadingTextStyle.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
      )),
      body: SafeArea(
        child: nakbaProvider.isDataLoaded
            ? CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: defaultPadding,
                        crossAxisSpacing: defaultPadding,
                        childAspectRatio: 0.78,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return SquareCard(
                            id: nakbaProvider.mainNakbaCatModel[index].id,
                            title: nakbaProvider.mainNakbaCatModel[index].title,
                            img: nakbaProvider.mainNakbaCatModel[index].img,
                            description: nakbaProvider
                                .mainNakbaCatModel[index].description!,
                            routeWhere: 'nakba_details',
                          );
                        },
                        childCount: nakbaProvider.mainNakbaCatModel.length,
                      ),
                    ),
                  ),
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
