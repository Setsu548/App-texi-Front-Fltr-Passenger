import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:texi_passenger/core/lang/delegates_lang.dart';
import 'package:texi_passenger/core/lang/supported_lang.dart';
import 'package:texi_passenger/core/utils/internet_service.dart';
import 'package:texi_passenger/core/utils/secure_storage_services.dart';
import 'package:texi_passenger/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;
  final internetService = InternetService();
  internetService.start();

  void setupLocator() {
    getIt.registerSingleton<SecureStorageService>(SecureStorageService());
  }

  setupLocator();
  await dotenv.load(fileName: ".env");
  runApp(
    I18n(
      localizationsDelegates: localizationsDelegates,
      initialLocale: await I18n.loadLocale(),
      supportedLocales: suportedLang,
      autoSaveLocale: true,
      child: ProviderScope(child: const MainApp()),
    ),
  );
}
