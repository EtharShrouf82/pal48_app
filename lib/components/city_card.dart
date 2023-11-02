import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/village_provider.dart';
import 'package:provider/provider.dart';

class CityCards extends StatelessWidget {
  final String img, map;
  final int id;
  final String title;
  final Color color;

  const CityCards({
    Key? key,
    required this.id,
    required this.img,
    required this.map,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final villageProvider =
        Provider.of<VillageProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        if (villageProvider.villageModel[id] == null) {
          villageProvider.villageModel[id] = [];
          villageProvider.fetchVillages(id);
        }
        Navigator.pushNamed(context, '/village', arguments: {
          'id': id,
          'city': title,
          'map': map,
        });
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        color: color,
        child: Column(
          children: [
            Image.asset(
              "assets/img/$img",
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color!,
                fontSize:
                    Theme.of(context).textTheme.bodyLarge!.fontSize! * 1.2,
                shadows: const <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 5.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
