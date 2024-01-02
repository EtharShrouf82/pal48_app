import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/aqsa_provider.dart';
import 'package:pal48/providers/nakba_provider.dart';
import 'package:provider/provider.dart';

class TitleCard extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final String goToPage;
  final List? images;

  const TitleCard({
    super.key,
    required this.id,
    required this.title,
    required this.goToPage,
    this.description,
    this.images,
  });

  @override
  Widget build(BuildContext context) {
    final nakbaProvider = Provider.of<NakbaProvider>(context, listen: false);
    final aqsaProvider = Provider.of<AqsaProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.02),
          textStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
          ),
        ),
        onPressed: () {
          if (goToPage == 'aqsa_details') {
            aqsaProvider.fetcAqsaSubCat(id);
          } else if (goToPage == 'aqsa_more_details') {
            aqsaProvider.fetcAqsaSubCat(id);
          } else {
            nakbaProvider.fetchNakbaSubCats(id);
          }

          Navigator.pushNamed(context, '/$goToPage', arguments: {
            'title': title,
            'id': id,
            'description': description,
            'images': images,
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SvgPicture.asset(
              "assets/svg/Arrow - Left.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
