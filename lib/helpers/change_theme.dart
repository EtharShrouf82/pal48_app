import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pal48/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);

    return FutureBuilder(
      future: themeProvider.getInitialTheme(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DayNightSwitcher(
            dayBackgroundColor: Colors.black,
            isDarkModeEnabled: themeProvider.getIsDark(),
            onStateChanged: (isDarkModeEnabled) {
              final provider =
                  Provider.of<AppThemeProvider>(context, listen: false);
              provider.toggleTheme(isDarkModeEnabled);
            },
          );
        }
        return const CircularProgressIndicator(); // or some other widget
      },
    );
  }
}
