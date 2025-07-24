import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/constant.dart';
import 'package:mailstr/controllers/auth_controller.dart';
import 'package:mailstr/controllers/theme_controller.dart';
import 'package:mailstr/get_database.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_ui/functions/n_restore_last_session.dart';
import 'package:ndk_ui/l10n/app_localizations.dart' as ndk_ui;
import 'package:sembast_cache_manager/sembast_cache_manager.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/screens/create/create_screen.dart';
import 'package:mailstr/screens/home/home_screen.dart';
import 'package:mailstr/screens/login/login_screen.dart';
import 'package:mailstr/screens/mailbox/mailbox_screen.dart';
import 'package:mailstr/screens/nip05/nip05_screen.dart';
import 'package:mailstr/screens/pay/pay_screen.dart';
import 'package:mailstr/screens/user/user_screen.dart';
import 'package:mailstr/middleware/auth_middleware.dart';
import 'package:mailstr/middleware/guest_middleware.dart';

import 'screens/mailbox/mailbox_controller.dart';

ThemeData _buildTheme(Brightness brightness, Color seedColor) {
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    ),
  ).copyWith(
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final ndk = Ndk(
    NdkConfig(
      cache: SembastCacheManager(await getDatabase()),
      eventVerifier: Bip340EventVerifier(),
    ),
  );

  await nRestoreLastSession(ndk);

  await GetStorage.init(appTitle);

  Get.put(ndk);
  Get.put(AuthController());
  Get.put(ThemeController());
  Get.put(MailboxController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return ToastificationWrapper(
          child: GetMaterialApp(
            title: appTitle,
            localizationsDelegates: [
              AppLocalizations.delegate,
              ndk_ui.AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: debugMode ? Locale('fr') : null,
            theme: _buildTheme(Brightness.light, themeController.accentColor),
            darkTheme: _buildTheme(
              Brightness.dark,
              themeController.accentColor,
            ),
            themeMode: themeController.themeMode,
            getPages: [
              GetPage(name: AppRoutes.home, page: () => HomeScreen()),
              GetPage(name: AppRoutes.create, page: () => CreateScreen()),
              GetPage(
                name: AppRoutes.login,
                page: () => LoginScreen(),
                middlewares: [GuestMiddleware()],
              ),
              GetPage(
                name: AppRoutes.mailbox,
                page: () => MailboxScreen(),
                middlewares: [AuthMiddleware()],
              ),
              GetPage(
                name: AppRoutes.nip05,
                page: () => Nip05Screen(),
                middlewares: [AuthMiddleware()],
              ),
              GetPage(
                name: AppRoutes.user,
                page: () => UserScreen(),
                middlewares: [AuthMiddleware()],
              ),
              GetPage(
                name: "${AppRoutes.unlockEmail}/:email",
                page: () => PayScreen(),
              ),
            ],
          ),
        );
      },
    );
  }
}
