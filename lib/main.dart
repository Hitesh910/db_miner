import 'package:db_miner/screen/home/controller/home_controller.dart';
import 'package:db_miner/utils/app_routes.dart';
import 'package:db_miner/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


// HomeController controller = Get.put(HomeController());

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  HomeController controller = Get.put(HomeController());
  controller.getTheme();
  runApp(
    Obx(
      () =>  GetMaterialApp(
        color: Colors.indigo.shade900,
            theme: controller.theme.value == false ?lightTheme :darkTheme,
          // darkTheme: ThemeData.dark(),
          // themeMode: ThemeMode.dark,
          // controller.theme.value == true ?light :dark,
          routes: app_routes,
        ),
    ),

  );
}