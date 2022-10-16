import 'package:club_atlhetica/pages/home_page/home_bindings.dart';
import 'package:club_atlhetica/pages/home_page/home_page.dart';
import 'package:club_atlhetica/pages/login/login_bindings.dart';
import 'package:club_atlhetica/pages/login/login_page.dart';
import 'package:club_atlhetica/pages/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

import 'layers/service/workmanager/workmanager_background.dart';



void main()async{
  /*WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(
    callbackDispatcher,
  );
  await Workmanager().registerPeriodicTask(
    "5",
    'fetchBackground',
    initialDelay: const Duration(seconds: 10),
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeLight.theme,
      darkTheme: AppThemeDark.theme,
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginPage(), binding: LoginBindings()),
        GetPage(name: '/home', page: () => const HomePage(), binding: HomeBindings()),
        GetPage(name: '/profile', page: () => const ProfilePage())
      ],
    );
  }
}

class AppThemeDark {
  static final theme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Colors.green,
      primaryContainer: Colors.white,
      secondary: Color(0xff565560),
      secondaryContainer: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.grey.shade900,
    cardColor: const Color(0xff3F3F40),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.green,
    bottomAppBarColor: const Color(0xff434343),
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Colors.white70),
    ),
  );
}

class AppThemeLight {
  static final theme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colors.green,
      secondary: Color(0xff565560),
    ),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    bottomAppBarColor: Colors.white,
    primarySwatch: Colors.deepPurple,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.green,
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Color(0xff5A5A5A)),
    ),
  );
}