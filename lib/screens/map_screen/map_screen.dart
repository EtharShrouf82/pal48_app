import 'package:flutter/material.dart';
import 'package:pal48/constants/constants.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text(
                'يقولون ضاعت أرضي، محيت ذكرياتي من عقلي، يقولون هدم بيتي، حرقت بساتيني وزرعي، أقول لا لم تمحى الذكريات يوما لم تغب شمس الأمال عن عيني، هناك بيتي هناك أرضي، هناك قدسي، أراها في صحوي ونومي، الحلم واحد بيني وبين اخواني في كل شبر لملمتنا فيه أرضا واحدة لبنان أو سوريا أو عمان أو بقاع، أعيش فيها لاجئاً لا لست لاجئاً لي وطن لي أرض لي هوية لن تمحوها السنون مهما تعالت أصوات الغاصبون، مهما دوت كلمات الذل في أبواق الخائنون فأنا سأعود سأطوي كل الحدود ، سأكسر الأسوار والقيود، وإليكي يا قدس صدقيني سأعود.',
                style: kSubHeadTextStyle.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: defaultPadding * 3,
              ),
              Image.asset(
                "assets/img/pal.png",
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
