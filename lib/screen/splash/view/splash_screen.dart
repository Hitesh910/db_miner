import 'package:db_miner/screen/home/controller/home_controller.dart';
import 'package:db_miner/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbib_splash_screen/splash_screen.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import '../../category/controller/category_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CategoryController controller = Get.put(CategoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.getData();
    Future.delayed(Duration(seconds: 4),() {
      Navigator.pushReplacementNamed(context, "/home");
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SplashScreenView(
        navigateRoute: HomeScreen(),
        imageSrc: "assets/images/logo.png",
        text: WavyAnimatedText("Quotes App",
            textStyle: TextStyle(
                fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
      )
          // Image.asset("assets/images/quotes.png"),
          ),
    );
  }
}
