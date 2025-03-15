import 'package:flutter_test/flutter_test.dart';
import 'package:kohab/core/theme/dark_mode.dart';
import 'package:kohab/core/theme/light_mode.dart';
import 'package:kohab/core/theme/theme_provider.dart';

void main() {
  group('ThemeProvider Tests', () {
    late ThemeProvider themeProvider;

    setUp(() {
      themeProvider = ThemeProvider();
    });

    test('initial theme should be dark theme', () {
      expect(themeProvider.themeData, equals(darkTheme));
      expect(themeProvider.isDarkMode, true);
    });

    test('toggleTheme should switch between light and dark themes', () {
      // Initially dark theme
      expect(themeProvider.isDarkMode, true);

      // Toggle to light theme
      themeProvider.toggleTheme();
      expect(themeProvider.themeData, equals(lightTheme));
      expect(themeProvider.isDarkMode, false);

      // Toggle back to dark theme
      themeProvider.toggleTheme();
      expect(themeProvider.themeData, equals(darkTheme));
      expect(themeProvider.isDarkMode, true);
    });

    test('setting themeData should notify listeners', () {
      bool listenerCalled = false;
      themeProvider.addListener(() {
        listenerCalled = true;
      });

      themeProvider.themeData = lightTheme;
      expect(listenerCalled, true);
    });
  });
}
