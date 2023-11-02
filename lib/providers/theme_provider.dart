import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  AppThemeProvider() {
    setinitThemeColor();
  }
  ThemeMode themeMode = ThemeMode.light;
  bool? initialTheme;
  // Color kBackgroundColor = const Color(0xFFF9F9FF);
  // Color kPrimaryColor = const Color(0xFF0976B8);
  // Color kWhiteColor = const Color(0xFFFFFFFF);
  Color kgrayColor = const Color(0XFF000000);
  // Color black2 = const Color(0xff333333);
  // Color kBlackColor = const Color(0xff000000);
  // Color kGrayDarkColor = const Color(0xff6c757d);
  // Color? kGrayOpacityColor = Colors.grey[200];
  // Color black12 = Colors.black12;
  // Color sliderBackgroundColor = Colors.black;
  // String iconColor = "";

  getInitialTheme() async {
    final prefs = await SharedPreferences.getInstance();
    initialTheme = prefs.getBool('isDarkMode');
    return 'l';
  }

  setinitThemeColor() async {
    await getInitialTheme();
    if (initialTheme ?? false) {
      toggleTheme(initialTheme ?? false);
    }
  }
  // bool get isDarkMode {

  // }
  bool getIsDark() {
    if (initialTheme != null) {
      return initialTheme ?? true;
    }
    if (themeMode == ThemeMode.system) {
      // ignore: deprecated_member_use
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isOn);
    await getInitialTheme();
    if (isOn) {
      // kWhiteColor = const Color(0xFF162740);
      // kBackgroundColor = const Color(0xFF161F32);
      // kBlackColor = const Color(0xFFFFFFFF);
      // iconColor = "_white";
      kgrayColor = const Color(0XFFFFFFFF);
      // kGrayOpacityColor = const Color(0XFF162740);
      // black12 = const Color(0xffF8F8F8);
      // black2 = const Color(0xFF162740);
      // sliderBackgroundColor = const Color(0XFF161F32);
    } else {
      // kWhiteColor = const Color(0xFFFFFFFF);
      // kBackgroundColor = const Color(0xfff8f8f8);
      // kBlackColor = const Color(0xff000000);
      kgrayColor = const Color(0XFF000000);
      // kGrayOpacityColor = Colors.grey[200];
      // black12 = Colors.black12;
      // black2 = const Color(0xff333333);
      // sliderBackgroundColor = Colors.black;
      // iconColor = "";
    }
    notifyListeners();
  }
}

// class MyThemes {
//   static final darkTheme = ThemeData(
//     scaffoldBackgroundColor: const Color(0xFF161F32),
//     primaryColor: const Color(0xffC58E20),
//     colorScheme: const ColorScheme.dark(),
//     fontFamily: 'DIN',
//     drawerTheme: const DrawerThemeData(
//       backgroundColor: Color(0xFF162740),
//     ),
//     primaryColorDark: const Color(0xFF161F32),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF0976B8),
//         foregroundColor: Colors.white,
//       ),
//     ),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xFF0976B8),
//       systemOverlayStyle: SystemUiOverlayStyle.light,
//     ),
//   );

//   static final lightTheme = ThemeData(
//     scaffoldBackgroundColor: const Color(0xfff8f8f8),
//     primaryColor: const Color(0xFF0976B8),
//     colorScheme: const ColorScheme.light(),
//     fontFamily: 'DIN',
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF0976B8),
//         foregroundColor: Colors.white,
//       ),
//     ),
//     // primarySwatch: Colors.grey,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xFF0976B8),
//       systemOverlayStyle: SystemUiOverlayStyle.light,
//     ),
//   );
// }
