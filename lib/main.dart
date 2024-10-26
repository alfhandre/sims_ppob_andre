import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_andre/providers/balance_provider.dart';
import 'package:sims_ppob_andre/providers/banner_provider.dart';
import 'package:sims_ppob_andre/providers/service_provider.dart';
import 'package:sims_ppob_andre/utils/storage_util.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';
import 'providers/auth_provider.dart';
import './screen/auth/login_screen.dart';
import './screen/navigator/navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => BalanceProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (context) => BannerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            labelLarge: TextStyle(fontSize: 16),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  void startTime() async {
    await Future.delayed(const Duration(seconds: 2));

    String? token = await StorageUtil.getToken();

    if (token == null || token.isEmpty) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NavigatorPage(id: 0)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/pictures/Logo.png',
              width: 200,
            ),
            const SizedBox(height: 12),
            Roboto.bold(text: "SIMS PPOB", fontSize: 36),
            const SizedBox(height: 18),
            Roboto.light(
                text: "Andre Lutfiasnyah", fontSize: 16, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
