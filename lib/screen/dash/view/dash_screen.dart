import 'package:db_miner/screen/category/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
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
      // appBar: AppBar(
      //   // title: Text("Db_miner"),
      // ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.categoryList.length,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Image.network(
              //   "${controller.categoryList[index].image![index]}",
              //   fit: BoxFit.fill,
              //   width: MediaQuery.sizeOf(context).width,
              //   height: MediaQuery.sizeOf(context).height,
              // ),
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("${controller.categoryList[index].image![index]}"),fit: BoxFit.cover,opacity: 0.8)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${controller.categoryList[index].quotes![index]}",style: TextStyle(fontSize: 18),),
                    Align(alignment: Alignment.centerRight,child: Text("${controller.categoryList[index].author![index]}")),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
