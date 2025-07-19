import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mailstr/config.dart';

enum AccentColorType { defaultColor, pictureColor, bannerColor }

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  // GetStorage instance
  final _storage = GetStorage();

  // Storage keys
  static const String _themeModeKey = 'theme_mode';
  static const String _accentColorTypeKey = 'accent_color_type';
  static const String _pictureColorKey = 'picture_color';
  static const String _bannerColorKey = 'banner_color';

  // Observable theme mode
  final _themeMode = ThemeMode.system.obs;
  ThemeMode get themeMode => _themeMode.value;

  // Observable accent color
  final _accentColorType = AccentColorType.defaultColor.obs;
  final _customAccentColor = defaultThemeColor.obs;
  
  // Store extracted colors for each type
  Color? _pictureColor;
  Color? _bannerColor;
  
  AccentColorType get accentColorType => _accentColorType.value;
  Color get accentColor => _customAccentColor.value;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

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
    update(); // Force UI rebuild to update indicators
  }

  // Set specific theme mode
  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
    _saveThemeMode();
    update(); // Force UI rebuild to update indicators
  }

  // Set accent color type
  void setAccentColorType(AccentColorType type) {
    _accentColorType.value = type;
    _updateAccentColor();
    _saveAccentColorType();
  }

  // Set custom accent color (for picture/banner colors)
  void setCustomAccentColor(Color color) {
    _customAccentColor.value = color;
    // Force rebuild to apply new theme
    update();
  }

  void _updateAccentColor() {
    switch (_accentColorType.value) {
      case AccentColorType.defaultColor:
        _customAccentColor.value = defaultThemeColor;
        break;
      case AccentColorType.pictureColor:
        _customAccentColor.value = _pictureColor ?? defaultThemeColor;
        break;
      case AccentColorType.bannerColor:
        _customAccentColor.value = _bannerColor ?? defaultThemeColor;
        break;
    }
    update();
  }

  // Extract color from image provider
  Future<void> extractColorFromImage(ImageProvider imageProvider, AccentColorType type) async {
    try {
      final ColorScheme colorScheme = await ColorScheme.fromImageProvider(provider: imageProvider);
      
      // Store the extracted color
      switch (type) {
        case AccentColorType.pictureColor:
          _pictureColor = colorScheme.primary;
          _savePictureColor(colorScheme.primary);
          break;
        case AccentColorType.bannerColor:
          _bannerColor = colorScheme.primary;
          _saveBannerColor(colorScheme.primary);
          break;
        case AccentColorType.defaultColor:
          // No need to store for default
          break;
      }
      
      // If this is the currently selected type, update the current color
      if (_accentColorType.value == type) {
        _customAccentColor.value = colorScheme.primary;
        update();
      }
    } catch (e) {
      print('Error extracting color from image: $e');
      // Fallback to default color
      if (_accentColorType.value == type) {
        _customAccentColor.value = defaultThemeColor;
        update();
      }
    }
  }

  // Extract color from picture
  Future<void> extractColorFromPicture(ImageProvider imageProvider) async {
    await extractColorFromImage(imageProvider, AccentColorType.pictureColor);
  }

  // Extract color from banner
  Future<void> extractColorFromBanner(ImageProvider imageProvider) async {
    await extractColorFromImage(imageProvider, AccentColorType.bannerColor);
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

  // Get current accent color type as string for display
  String get accentColorTypeString {
    switch (_accentColorType.value) {
      case AccentColorType.defaultColor:
        return 'Default';
      case AccentColorType.pictureColor:
        return 'Picture Color';
      case AccentColorType.bannerColor:
        return 'Banner Color';
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

  // Storage methods
  void _loadSettings() {
    // Load theme mode
    final themeModeIndex = _storage.read(_themeModeKey);
    if (themeModeIndex != null) {
      _themeMode.value = ThemeMode.values[themeModeIndex];
      Get.changeThemeMode(_themeMode.value);
    }

    // Load accent color type
    final accentTypeIndex = _storage.read(_accentColorTypeKey);
    if (accentTypeIndex != null) {
      _accentColorType.value = AccentColorType.values[accentTypeIndex];
    }

    // Load extracted colors
    final pictureColorValue = _storage.read(_pictureColorKey);
    if (pictureColorValue != null) {
      _pictureColor = Color(pictureColorValue);
    }

    final bannerColorValue = _storage.read(_bannerColorKey);
    if (bannerColorValue != null) {
      _bannerColor = Color(bannerColorValue);
    }

    // Update accent color based on loaded settings
    _updateAccentColor();
  }

  void _saveThemeMode() {
    _storage.write(_themeModeKey, _themeMode.value.index);
  }

  void _saveAccentColorType() {
    _storage.write(_accentColorTypeKey, _accentColorType.value.index);
  }

  void _savePictureColor(Color color) {
    _storage.write(_pictureColorKey, color.value);
  }

  void _saveBannerColor(Color color) {
    _storage.write(_bannerColorKey, color.value);
  }
}