import 'package:flutter/material.dart';
import 'package:pal48/Helpers/open_link.dart';
import 'package:pal48/constants/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(defaultPadding),
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text(
                'كي لا ننسى - فلسطيننا',
                style: kSubHeadTextStyle.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'تم إنشاء موقع وتطبيق فلسطيننا، بجهد شخصي، في محاولة للحفاظ على الذاكرة الفلسطينية وإيصال جرائم الإحتلال لجميع أنحاء العالم',
                style: kSubHeadTextStyle.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'باب المشاركة في الموقع متاح للجميع، سواء بالترجمة للغات أخرى، أو إضافة معلومات ومواضيع جديده، أو حتى تعديل بعض المعلومات إن كانت خطأ.',
                style: kSubHeadTextStyle.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'يحتاج الموقع لمترجمين في شتى اللغات من أجل ترجمة الموقع للغات أخرى.',
                style: kSubHeadTextStyle.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'حاليا يتم إنشاء محتوى بعنوان أكاذيب إسرائيلية، حيث يحاول الإحتلال سرقة التراث الفلسطيني، فأي معلومة تفيد في هذا المجال يرجى مراسلة الموقع بها.',
                style: kSubHeadTextStyle.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Text(
                'لا يتطلب الموقع أي بيانات خاصه من المستخدمين وبالإمكان الإطلاع على سياسة الخصوصية من هنا',
                style: kSubHeadTextStyle.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
                color: primaryColor,
                width: double.infinity,
                child: Text(
                  'طاقم العمل',
                  style: kHeadingTextStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  openLink("https://www.etharshrouf.com");
                },
                child: ListTile(
                  title: Text(
                    'إيثار شروف - مبرمج',
                    style: kSubHeadTextStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'أنصار شروف - البيانات',
                  style: kSubHeadTextStyle.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'نزار شروف - مصمم',
                  style: kSubHeadTextStyle.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
