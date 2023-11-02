import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pal48/Api/Api.dart';
import 'package:pal48/components/page_appbar.dart';
import 'package:pal48/components/text_form_field.dart';
import 'package:pal48/constants/constants.dart';
import 'package:pal48/providers/contact_us_provider.dart';
import 'package:pal48/providers/device_token_provider.dart';
import 'package:pal48/services/add_message_service.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final contactUsProvider = Provider.of<ContactProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: PageAppBar(
          title: 'إتصل بنا',
          share: '${Api.url}/app',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'لنبقى على تواصل',
                          style: kHeadingTextStyle.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        TextFormFieldUi(
                          controller: contactUsProvider.name,
                          textInputType: TextInputType.name,
                          validationNumber: 0,
                          validationMessage: '',
                          maxLines: 1,
                          prefixIcon: Icons.person,
                          labelTxt: 'الإسم - إختياري',
                          errorMsg: '',
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        TextFormFieldUi(
                          controller: contactUsProvider.email,
                          textInputType: TextInputType.emailAddress,
                          validationNumber: 0,
                          validationMessage: '',
                          maxLines: 1,
                          prefixIcon: Icons.email,
                          labelTxt: 'البريد الإلكتروني - إختياري',
                          errorMsg: '',
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        TextFormFieldUi(
                          controller: contactUsProvider.message,
                          textInputType: TextInputType.text,
                          validationNumber: 20,
                          validationMessage:
                              'نص الرسالة يجب على الأقل أن يحتوي على 30 حرف',
                          maxLines: 4,
                          prefixIcon: Icons.message,
                          labelTxt: 'نص الرسالة',
                          errorMsg: 'الرجاء إدخال نص الرسالة',
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Center(
                          child: contactUsProvider.isMessageSent
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
                                      contactUsProvider,
                                    );
                                  },
                                  child: const Text("إضافة التعليق"),
                                ),
                        ),
                        const SizedBox(
                          height: defaultPadding * 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit(
      context, formKey, ContactProvider contactProvider) async {
    final sendMessageClass = SendMessageClass();
    if (!formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    formKey.currentState!.save();
    contactProvider.changeLoadingStatus();
    await Future.delayed(const Duration(milliseconds: 100), () {
      sendMessageClass
          .sendMessage(
        contactProvider.name.text,
        contactProvider.email.text,
        contactProvider.message.text,
        Provider.of<DeviceTokensProvider>(context, listen: false).deviceToken,
      )
          .then((value) async {
        if (value == 'success') {
          ArtDialogResponse response = await ArtSweetAlert.show(
            barrierDismissible: false,
            context: context,
            artDialogArgs: ArtDialogArgs(
              title: "تم إرسال الرسالة بنجاح",
              confirmButtonText: "إغلاق",
              type: ArtSweetAlertType.success,
            ),
          );

          // ignore: unnecessary_null_comparison
          if (response == null) {}

          if (response.isTapConfirmButton) {
            contactProvider.emptyField();
          }
        }
      });
      contactProvider.changeLoadingStatus();
    });
  }
}
