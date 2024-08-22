import 'dart:ffi';

import 'package:db_miner/screen/category/controller/category_controller.dart';
import 'package:db_miner/screen/category/view/category_screen.dart';
import 'package:db_miner/screen/dash/view/dash_screen.dart';
import 'package:db_miner/screen/favourite/view/favourite_screen.dart';
import 'package:db_miner/screen/home/controller/home_controller.dart';
import 'package:db_miner/utils/helper/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  CategoryController categoryController = Get.put(CategoryController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryController.getData();
  }

  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Db_miner"),
        actions: [

           DrawerButton()

        ],
      ),
      body: Obx(
        () =>  controller.i.value == 0
            ? DashScreen()
            : controller.i.value == 1
                ? CategoryScreen()
                : FavouriteScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            controller.i.value = value;
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home"
            ),
            const BottomNavigationBarItem(icon: Icon(Icons.category),label: "category"),
            const BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "favourite")
          ]),
      drawer: Drawer(
        child: Padding(
          padding:
          const EdgeInsets.only(top: 40, bottom: 10, right: 10, left: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Theme"),
                  const Spacer(),
                  Obx(
                        () =>  Switch(value: controller.theme.value, onChanged: (value) {
                      print(value);
                      controller.theme.value = value;
                      SharedHelper helper = SharedHelper();
                      helper.setTheme(controller.theme.value);
                    },),
                  ),
                ],
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'favourite');
                },
                child: const Row(
                  children: [
                    Icon(Icons.favorite),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Favourite")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
