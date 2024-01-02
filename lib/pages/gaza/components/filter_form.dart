import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/gaza_provider.dart';

class FilterForm extends StatelessWidget {
  final GazaProvider gazaProvide;

  const FilterForm({super.key, required this.gazaProvide});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          itemCount: gazaProvide.tagModel.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductFilter(
              title: gazaProvide.tagModel[index].tag,
              isActive:
                  gazaProvide.currentTag == gazaProvide.tagModel[index].id,
              count: gazaProvide.tagModel[index].count,
              onPressed: () {
                gazaProvide.currentTag == gazaProvide.tagModel[index].id
                    ? gazaProvide.getAll()
                    : gazaProvide.filter(gazaProvide.tagModel[index].id);
              },
              filterValue: gazaProvide.tagModel[index].id,
            );
          }),
    );
  }
}

class ProductFilter extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final int filterValue, count;
  final bool isActive;

  const ProductFilter({
    super.key,
    required this.title,
    required this.count,
    required this.onPressed,
    required this.filterValue,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          margin: const EdgeInsets.only(left: 8),
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 3.0,
          ),
          decoration: BoxDecoration(
            color: isActive ? primaryColor : null,
            border: Border.all(
                color: isActive
                    ? primaryColor
                    : Theme.of(context).textTheme.bodyLarge!.color!),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: kHintTextStyle.copyWith(
                  fontSize: 11,
                  color: isActive
                      ? whiteColor
                      : Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(
                width: 3.0,
              ),
              Text(
                '($count)',
                style: kHintTextStyle.copyWith(
                  fontSize: 11,
                  color: isActive
                      ? whiteColor
                      : Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(
                width: 3.0,
              ),
              SvgPicture.asset(
                isActive ? "assets/svg/Close.svg" : "assets/svg/Filter.svg",
                height: 14,
                width: 14,
                colorFilter: ColorFilter.mode(
                  isActive
                      ? whiteColor
                      : Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
