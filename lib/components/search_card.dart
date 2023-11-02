import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/constants/constants.dart';

class SearchCard extends StatelessWidget {
  final String? img;
  final String title;
  final int id;
  final String desc;
  final List? images;

  const SearchCard({
    super.key,
    this.img,
    required this.title,
    required this.id,
    required this.desc,
    this.images,
  });

  @override
  Widget build(BuildContext context) {
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
          Navigator.pushNamed(context, '/details', arguments: {
            'title': title,
            'id': id,
            'desc': desc,
            'img': img,
            'images': images,
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
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
