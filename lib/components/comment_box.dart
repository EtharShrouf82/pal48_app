import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/constants.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({
    Key? key,
    this.name,
    required this.comment,
    required this.time,
  }) : super(key: key);

  final String? name;
  final String comment, time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.05),
        borderRadius:
            const BorderRadius.all(Radius.circular(defaultBorderRadious)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: defaultPadding / 2),
              name != null
                  ? Text(
                      name!,
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  : const SizedBox(),
              const SizedBox(width: defaultPadding / 4),
              Text(
                time,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  showConfirmDialog(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/Dislike.svg',
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.bodySmall!.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: defaultPadding / 2,
                    ),
                    Text(
                      'الإبلاغ عن تعليق مسيئ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: defaultPadding),
          Text(
            comment,
            style: kPragraphTextStyle.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          )
        ],
      ),
    );
  }
}

showConfirmDialog(BuildContext context) async {
  ArtDialogResponse response = await ArtSweetAlert.show(
      barrierDismissible: false,
      context: context,
      artDialogArgs: ArtDialogArgs(
          denyButtonText: "لا",
          title: "الإبلاغ عن تعليق",
          text: "هل تريد بالتأكيد الإبلاغ عن تعليق مسيئ",
          confirmButtonText: "نعم",
          type: ArtSweetAlertType.warning));

  // ignore: unnecessary_null_comparison
  if (response == null) {
    return;
  }

  if (response.isTapConfirmButton) {
    // ignore: use_build_context_synchronously
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success, title: "تم الإبلاغ بنجاح"));
    return;
  }
}
