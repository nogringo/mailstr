import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mailstr/config.dart';
import 'package:ndk/ndk.dart';

enum AccentColorType { defaultColor, pictureColor, bannerColor }

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  // GetStorage instance
  final _storage = GetStorage(appTitle);

  // Storage keys
  static const String _themeModeKey = 'theme_mode';
  static const String _accentColorTypeKey = 'accent_color_type';
  static const String _pictureColorKey = 'picture_color';
  static const String _bannerColorKey = 'banner_color';

  // Get user-specific storage key
  String _getUserSpecificKey(String baseKey) {
    final ndk = Get.find<Ndk>();
    final pubkey = ndk.accounts.getPublicKey();
    return pubkey != null ? '${baseKey}_$pubkey' : baseKey;
  }

  // Convert Color to hex string
  String colorToHex(Color color) {
    final r = (color.r * 255).round().toRadixString(16).padLeft(2, '0');
    final g = (color.g * 255).round().toRadixString(16).padLeft(2, '0');
    final b = (color.b * 255).round().toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }

  // Convert hex string to Color
  Color hexToColor(String hex) {
    // Remove # prefix if present
    final cleanHex = hex.startsWith('#') ? hex.substring(1) : hex;
    
    // Ensure we have at least 6 characters for RGB
    if (cleanHex.length < 6) {
      throw ArgumentError('Invalid hex color: $hex');
    }
    
    // Parse RGB values (first 6 characters)
    final r = int.parse(cleanHex.substring(0, 2), radix: 16);
    final g = int.parse(cleanHex.substring(2, 4), radix: 16);
    final b = int.parse(cleanHex.substring(4, 6), radix: 16);
    
    // Use full opacity (255) for alpha
    return Color.fromARGB(255, r, g, b);
  }

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

  // Reset colors to default (call on logout)
  void resetToDefaultColors() {
    _pictureColor = null;
    _bannerColor = null;
    _accentColorType.value = AccentColorType.defaultColor;
    _customAccentColor.value = defaultThemeColor;
    update();
  }

  // Handle account switching (call when switching accounts)
  Future<void> switchAccount() async {
    // Reset to default colors first
    resetToDefaultColors();
    
    // Then load colors for the new account
    await loadUserColors();
  }

  // Load user-specific colors (call after login)
  Future<void> loadUserColors() async {
    final ndk = Get.find<Ndk>();
    final pubkey = ndk.accounts.getPublicKey();
    
    if (pubkey == null) return;

    // Load extracted colors (user-specific)
    final pictureKey = _getUserSpecificKey(_pictureColorKey);
    final pictureColorValue = _storage.read(pictureKey);
    
    bool pictureColorLoaded = false;
    if (pictureColorValue != null) {
      try {
        if (pictureColorValue is String) {
          _pictureColor = hexToColor(pictureColorValue);
          pictureColorLoaded = true;
        } else if (pictureColorValue is int) {
          // Legacy format - migrate to new format
          _pictureColor = Color(pictureColorValue);
          _savePictureColor(_pictureColor!);
          pictureColorLoaded = true;
        }
      } catch (e) {
        // Invalid color format, ignore
      }
    }

    final bannerKey = _getUserSpecificKey(_bannerColorKey);
    final bannerColorValue = _storage.read(bannerKey);
    bool bannerColorLoaded = false;
    if (bannerColorValue != null) {
      try {
        if (bannerColorValue is String) {
          _bannerColor = hexToColor(bannerColorValue);
          bannerColorLoaded = true;
        } else if (bannerColorValue is int) {
          // Legacy format - migrate to new format
          _bannerColor = Color(bannerColorValue);
          _saveBannerColor(_bannerColor!);
          bannerColorLoaded = true;
        }
      } catch (e) {
        // Invalid color format, ignore
      }
    }

    // If no colors were loaded, this is a new user - extract colors from their metadata
    if (!pictureColorLoaded || !bannerColorLoaded) {
      try {
        final metadata = await ndk.metadata.loadMetadata(pubkey);
        
        // Extract picture color if not loaded and user has a picture
        if (!pictureColorLoaded && metadata?.picture != null && metadata!.picture!.isNotEmpty) {
          final imageProvider = NetworkImage(metadata.picture!);
          await extractColorFromPicture(imageProvider);
        }
        
        // Extract banner color if not loaded and user has a banner
        if (!bannerColorLoaded && metadata?.banner != null && metadata!.banner!.isNotEmpty) {
          final imageProvider = NetworkImage(metadata.banner!);
          await extractColorFromBanner(imageProvider);
        }
      } catch (e) {
        // Error loading metadata or extracting colors, ignore
      }
    }

    // Update accent color based on loaded settings
    _updateAccentColor();
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

    // Load extracted colors (user-specific)
    final pictureKey = _getUserSpecificKey(_pictureColorKey);
    final pictureColorValue = _storage.read(pictureKey);
    if (pictureColorValue != null) {
      try {
        if (pictureColorValue is String) {
          _pictureColor = hexToColor(pictureColorValue);
        } else if (pictureColorValue is int) {
          // Legacy format - migrate to new format
          _pictureColor = Color(pictureColorValue);
          _savePictureColor(_pictureColor!);
        }
      } catch (e) {
        // Invalid color format, ignore
      }
    }

    final bannerColorValue = _storage.read(_getUserSpecificKey(_bannerColorKey));
    if (bannerColorValue != null) {
      try {
        if (bannerColorValue is String) {
          _bannerColor = hexToColor(bannerColorValue);
        } else if (bannerColorValue is int) {
          // Legacy format - migrate to new format
          _bannerColor = Color(bannerColorValue);
          _saveBannerColor(_bannerColor!);
        }
      } catch (e) {
        // Invalid color format, ignore
      }
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
    final key = _getUserSpecificKey(_pictureColorKey);
    final hex = colorToHex(color);
    _storage.write(key, hex);
  }

  void _saveBannerColor(Color color) {
    _storage.write(_getUserSpecificKey(_bannerColorKey), colorToHex(color));
  }
}