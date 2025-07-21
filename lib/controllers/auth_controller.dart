import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_ui/ndk_ui.dart';
import 'package:mailstr/controllers/theme_controller.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  
  Ndk get ndk => Get.find<Ndk>();
  
  // Make auth state reactive
  final RxBool _isLoggedIn = false.obs;
  
  // Expose the reactive boolean for other controllers to listen to
  RxBool get isLoggedInRx => _isLoggedIn;
  
  // Always get the real-time state from NDK
  bool get isLoggedIn {
    final currentState = ndk.accounts.isLoggedIn;
    if (_isLoggedIn.value != currentState) {
      _isLoggedIn.value = currentState;
    }
    return currentState;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize with current state
    _updateAuthState();
    
    // Restore session and initialize user data
    _restoreSessionAndInitialize();
    
    // Listen to NDK auth changes
    ever(_isLoggedIn, (bool loggedIn) {
      // This will trigger UI updates when auth state changes
      update(); // Also call update to ensure GetBuilder widgets update
    });
    
    // Periodically check NDK state to catch any missed updates
    Stream.periodic(Duration(seconds: 1)).listen((_) {
      final currentState = ndk.accounts.isLoggedIn;
      if (_isLoggedIn.value != currentState) {
        _isLoggedIn.value = currentState;
        update();
      }
    });
  }

  Future<void> _restoreSessionAndInitialize() async {
    // Try to restore last session
    final wasRestored = await nRestoreLastSession(ndk);

    if (wasRestored && ndk.accounts.isLoggedIn) {
      // Update auth state
      _updateAuthState();

      // Load user-specific theme colors
      try {
        await Get.find<ThemeController>().loadUserColors();
      } catch (e) {
        // ThemeController might not be initialized yet, that's ok
      }
    }
  }

  void _updateAuthState() {
    _isLoggedIn.value = ndk.accounts.isLoggedIn;
  }

  // Call this method when login state changes
  void updateAuthState() {
    _updateAuthState();
    update(); // Force rebuild of GetBuilder widgets
  }
}