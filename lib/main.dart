import 'package:flutter/material.dart';
import 'package:izin_kebun_app/helpers/qrcode_service.dart';
import 'package:izin_kebun_app/helpers/sharedPreferences.dart';
import 'package:izin_kebun_app/src/view/login.dart';
import 'package:izin_kebun_app/src/view/verification.dart';
import 'package:izin_kebun_app/src/view/welcome.dart';
import 'package:izin_kebun_app/helpers/navigator.dart';
import 'package:izin_kebun_app/src/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesManager prefsManager =
      await SharedPreferencesManager.getInstance();
  bool isFirstTimeLaunch = prefsManager.loadValue('isFirstTimeLaunch', false);
  if (!isFirstTimeLaunch) {
    await prefsManager.saveValue('isFirstTimeLaunch', true);
  }

  runApp(MyApp(isFirstTimeLaunch: isFirstTimeLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstTimeLaunch;

  const MyApp({super.key, this.isFirstTimeLaunch = false});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthViewModel())],
      child: MaterialApp(
        title: 'SRS Izin Kebun',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          fontFamily: 'Inter',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF047857)),
          useMaterial3: true,
        ),
        navigatorKey: NavigationService.instance.navigationKey,
        home: !isFirstTimeLaunch ? Welcome() : const Login(),
        routes: {
          '/home': (context) => Welcome(),
          '/login': (context) => const Login(),
          '/verification': (context) => Verification(),
          '/scanQr': (context) => const ScanQRCode(),
        },
        initialRoute: !isFirstTimeLaunch ? '/home' : '/login',
      ),
    );
  }
}
