import 'package:flutter/material.dart';
import 'package:pal48/services/contact_us_service.dart';

class ContactProvider extends ChangeNotifier {
  bool isLoading = true;

  bool isMessageSent = false;

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController message = TextEditingController();

  // bool messageSent = false;
  bool loadingPrivacy = false;
  bool loadingTermsData = false;
  String privaceData = '';
  String termsData = '';

  bool loadingReturnData = false;
  String returnData = '';

  changeLoadingStatus() {
    isLoading = !isLoading;
    notifyListeners();
  }

  emptyField() {
    name.text = '';
    email.text = '';
    message.text = '';
    notifyListeners();
  }

  var contactData = {};

  getContactData() async {
    isLoading = false;
    notifyListeners();
    final contactService = ContactService();
    await contactService.fetchContactUsInfo().then((res) {
      contactData = {
        'email': res['email'],
        'tel': res['tel'],
        'facebook': res['facebook'],
        'whatsapp': res['whatsapp'],
        'address': res['address'],
        'instagram': res['instagram'],
      };
    });
    isLoading = true;
    notifyListeners();
  }

  Future<void> getPrivacyData() async {
    loadingPrivacy = true;
    final contactService = ContactService();
    privaceData = await contactService.getPrivacy();
    loadingPrivacy = false;
    notifyListeners();
  }

  Future<void> getTermsData() async {
    loadingTermsData = true;
    final contactService = ContactService();
    privaceData = await contactService.getTerms();
    loadingTermsData = false;
    notifyListeners();
  }

  // Future<void> getReturnData() async {
  //   loadingReturnData = true;
  //   notifyListeners();
  //   final contactService = ContactService();
  //   returnData = await contactService.getReturnData();
  //   loadingReturnData = false;
  //   notifyListeners();
  // }
}
