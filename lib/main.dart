import 'package:flutter/material.dart';
import 'package:habbit_sphere/database/habbit_database.dart';
import 'package:habbit_sphere/pages/home_page.dart';
import 'package:habbit_sphere/pages/splash_page.dart';
import 'package:habbit_sphere/theme/light_mode.dart';
import 'package:habbit_sphere/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDataBase.initialize();
  await HabitDataBase().saveFirstLaunchDate();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => HabitDataBase(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const SplashPage(),
    );
  }
}
