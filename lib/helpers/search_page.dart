import 'package:flutter/material.dart';
import 'package:pal48/components/search_card.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/models/article_model.dart';
import 'package:pal48/services/article_service.dart';

class Search extends SearchDelegate<ArticleModel> {
  final search = ArticleService();
  final int follow;
  Search({
    required this.follow,
  });
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.close,
          color: query.isNotEmpty ? Colors.grey : Colors.white,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        query = '';
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: search.searchSuggestion(query, follow),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return snapshot.data!.isNotEmpty
                      ? SearchCard(
                          id: snapshot.data![index].id,
                          title: snapshot.data![index].title,
                          desc: snapshot.data![index].description,
                          img: snapshot.data![index].img,
                          images: snapshot.data![index].images,
                        )
                      : const Center(
                          child: Text(
                            'نأسف لا يوجد نتائج للبحث',
                            style: kHeadingTextStyle,
                          ),
                        );
                })
            : Container();
      },
    );
  }
}
