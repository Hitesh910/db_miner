import 'package:db_miner/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/quotes.png"),
      ),
    );
  }
}
