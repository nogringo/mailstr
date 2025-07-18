import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailstr/config.dart';
import 'package:mailstr/controllers/auth_controller.dart';
import 'package:mailstr/get_database.dart';
import 'package:mailstr/l10n/app_localizations.dart';
import 'package:ndk/ndk.dart';
import 'package:sembast_cache_manager/sembast_cache_manager.dart';
import 'package:toastification/toastification.dart';
import 'package:mailstr/app_routes.dart';
import 'package:mailstr/screens/create/create_screen.dart';
import 'package:mailstr/screens/home/home_screen.dart';
import 'package:mailstr/screens/mailbox/mailbox_screen.dart';
import 'package:mailstr/screens/pay/pay_screen.dart';

void main() async {
  Get.put(
    Ndk(
      NdkConfig(
        cache: SembastCacheManager(await getDatabase()),
        eventVerifier: Bip340EventVerifier(),
      ),
    ),
  );

  Get.put(AuthController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: kDebugMode ? Locale('en') : null,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: themeColor),
        ),
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: themeColor,
            brightness: Brightness.dark,
          ),
        ),
        getPages: [
          GetPage(name: AppRoutes.home, page: () => HomeScreen()),
          GetPage(name: AppRoutes.create, page: () => CreateScreen()),
          GetPage(name: AppRoutes.mailbox, page: () => MailboxScreen()),
          GetPage(name: AppRoutes.unlockEmail, page: () => PayScreen()),
        ],
      ),
    );
  }
}
