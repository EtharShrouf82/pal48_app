import 'package:flutter/material.dart';
import 'package:pal48/providers/gaza_provider.dart';
import 'package:provider/provider.dart';

class GazaImage extends StatelessWidget {
  const GazaImage({super.key});

  @override
  Widget build(BuildContext context) {
    final gaza = Provider.of<GazaProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        if (gaza.gazaModel.isEmpty) {
          gaza.getchGaza();
        }
        Navigator.pushNamed(context, '/gaza');
      },
      child: SizedBox(
        height: 150,
        child: Image.asset(
          'assets/img/gincode.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
