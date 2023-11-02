import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/components/question_cat_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/question_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class QuestionCatPage extends StatelessWidget {
  const QuestionCatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: questionProvider.isDataLoaded
            ? CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      "إختبر معلوماتك",
                      style: kHeadingTextStyle.copyWith(
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    floating: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          Share.share('${Api.url}/exam');
                        },
                        icon: SvgPicture.asset(
                          "assets/svg/Share.svg",
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).iconTheme.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(defaultPadding),
                    sliver: SliverToBoxAdapter(
                        child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: questionProvider.questionCatModel.map((e) {
                        questionProvider.fetchCorrect(e.id);
                        return QuestionCatCard(
                          id: e.id,
                          title: e.title,
                          numberOfQuestions: e.numberOfQuestions,
                          questionProvider: questionProvider,
                        );
                      }).toList(), // all the children is making an error
                    )),
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
