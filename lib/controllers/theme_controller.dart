import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  // Observable theme mode
  final _themeMode = ThemeMode.system.obs;
  ThemeMode get themeMode => _themeMode.value;

  // Toggle between light and dark theme
  void toggleTheme() {
    switch (_themeMode.value) {
      case ThemeMode.light:
        _themeMode.value = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        _themeMode.value = ThemeMode.light;
        break;
      case ThemeMode.system:
        // If system, switch to opposite of current brightness
        final brightness = Get.context?.mounted == true 
            ? MediaQuery.of(Get.context!).platformBrightness
            : Brightness.light;
        _themeMode.value = brightness == Brightness.light 
            ? ThemeMode.dark 
            : ThemeMode.light;
        break;
    }
    
    // Update the app theme
    Get.changeThemeMode(_themeMode.value);
  }

  // Set specific theme mode
  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
  }

  // Get current theme mode as string for display
  String get themeModeString {
    switch (_themeMode.value) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  // Get appropriate icon for current theme
  IconData get themeIcon {
    switch (_themeMode.value) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  // Check if current theme is dark
  bool get isDarkMode {
    if (_themeMode.value == ThemeMode.system) {
      final brightness = Get.context?.mounted == true 
          ? MediaQuery.of(Get.context!).platformBrightness
          : Brightness.light;
      return brightness == Brightness.dark;
    }
    return _themeMode.value == ThemeMode.dark;
  }
}