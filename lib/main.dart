import 'package:flutter/material.dart';
import 'package:izin_kebun_app/helpers/sharedPreferences.dart';
import 'package:izin_kebun_app/src/view/login.dart';
import 'package:izin_kebun_app/src/view/webview.dart';
import 'package:izin_kebun_app/src/view/welcome.dart';
import 'package:izin_kebun_app/helpers/navigator.dart';
import 'package:izin_kebun_app/src/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SharedPreferencesManager prefsManager =
      await SharedPreferencesManager.getInstance();
  await prefsManager.saveValue('isFirstTimeLaunch', true);
  bool isFirstTimeLaunch = prefsManager.loadValue('isFirstTimeLaunch', false);

  runApp(MyApp(isFirstTimeLaunch: isFirstTimeLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstTimeLaunch;

  const MyApp({super.key, this.isFirstTimeLaunch = false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthViewModel())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Inter',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          navigatorKey: NavigationService.instance.navigationKey,
          home: !isFirstTimeLaunch ? Welcome() : const Login(),
          routes: {
            '/home': (context) => Welcome(),
            '/login': (context) => const Login(),
            '/webview': (context) => const WebViewApp(),
          },
          initialRoute: !isFirstTimeLaunch ? '/home' : '/login',
        ));
  }
}
