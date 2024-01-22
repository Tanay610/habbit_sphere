import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habbit_sphere/components/habbit_sphere.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habbit_sphere/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return HomePage();
      }));
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Sphere(radius: 180, color: Colors.blue.shade500, widget: Center(child: Text("Habit Sphere",
        style: GoogleFonts.zenAntiqueSoft(
          textStyle: TextStyle(
            color: Colors.blue.shade900,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
        ),
        )),),
      ),
    );
  }
}