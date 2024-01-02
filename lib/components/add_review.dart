import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pal48/components/agree_with_terms.dart';
import 'package:pal48/components/text_form_field.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/helpers/get_locale.dart';
import 'package:pal48/providers/add_comment_provider.dart';
import 'package:pal48/providers/device_token_provider.dart';
import 'package:pal48/services/add_message_service.dart';
import 'package:provider/provider.dart';

class ReviewForm extends StatelessWidget {
  final String title;
  final String comment;
  final VoidCallback onPressed;
  final String model;
  final int id;

  const ReviewForm({
    super.key,
    required this.title,
    required this.comment,
    required this.onPressed,
    required this.model,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final commentProvider = Provider.of<AddCommentProvider>(context);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Text(
                title,
                style: kHeadingTextStyle.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              const SizedBox(height: defaultPadding),
              TextFormFieldUi(
                controller: commentProvider.name,
                textInputType: TextInputType.name,
                validationNumber: 0,
                validationMessage: '',
                maxLines: 1,
                prefixIcon: Icons.person,
                labelTxt: translation(context).optionalName,
                errorMsg: '',
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: defaultPadding),
              TextFormFieldUi(
                controller: commentProvider.email,
                textInputType: TextInputType.emailAddress,
                validationNumber: 0,
                validationMessage: '',
                maxLines: 1,
                prefixIcon: Icons.email,
                labelTxt: translation(context).optionalEmail,
                errorMsg: '',
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              TextFormFieldUi(
                controller: commentProvider.message,
                textInputType: TextInputType.text,
                validationNumber: 20,
                maxLength: 400,
                validationMessage: translation(context).messageAtLeast,
                maxLines: 4,
                prefixIcon: Icons.message,
                labelTxt: translation(context).comment,
                errorMsg: translation(context).commentMsg,
                textAlign: TextAlign.right,
              ),
              const AgreeWithTerms(),
              const SizedBox(height: defaultPadding),
              Center(
                child: commentProvider.isCommentSent
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () {
                          _submit(
                            context,
                            formKey,
                            commentProvider,
                            model,
                            id,
                          );
                        },
                        child: Text(
                          translation(context).addComment,
                          style: kPragraphTextStyle.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
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

  Future<void> _submit(
    context,
    formKey,
    AddCommentProvider addCommentProvider,
    String model,
    int id,
  ) async {
    final sendMessageClass = SendMessageClass();
    if (!formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    formKey.currentState!.save();
    addCommentProvider.inSendLoading();
    await Future.delayed(const Duration(milliseconds: 100), () {
      sendMessageClass
          .addComment(
        addCommentProvider.name.text,
        addCommentProvider.email.text,
        addCommentProvider.message.text,
        Provider.of<DeviceTokensProvider>(context, listen: false).deviceToken,
        id,
        model,
      )
          .then((value) async {
        if (value == 'success') {
          ArtDialogResponse response = await ArtSweetAlert.show(
            barrierDismissible: false,
            context: context,
            artDialogArgs: ArtDialogArgs(
              title: translation(context).successComment,
              confirmButtonText: translation(context).close,
              type: ArtSweetAlertType.success,
            ),
          );

          // ignore: unnecessary_null_comparison
          if (response == null) {}

          if (response.isTapConfirmButton) {
            addCommentProvider.emptyField();
            addCommentProvider.commentSent();
          }
        }
      });
    });
  }
}
