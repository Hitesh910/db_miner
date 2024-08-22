import 'package:db_miner/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List l1 = Get.arguments;
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${l1[2]}"),fit: BoxFit.fill
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() =>  Text("${l1[0]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: controller.isColor.value),)),
                      ),
                      Align(alignment: Alignment.centerRight, child: Text("${l1[1]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Row(
          //   children: [
          //     IconButton(onPressed: () {
          //         controller.color.value =! controller.color.value;
          //         print(controller.color.value);
          //       }, icon: Icon(Icons.color_lens)),
          //
          //   ],
          // ),
          Expanded(
            child: Row(children:
              List.generate(Colors.primaries.length, (index) {
                return Container(
                  height: 20,
                  width: 20,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.primaries[index]),
                );
              },)
              //   ListView.builder(itemCount: Colors.primaries.length, itemBuilder: (context, index) {
              //   return Container(
              //     height: 40,
              //     width: 40,
              //     child: Text("$index"),
              //     decoration: BoxDecoration(color: Colors.primaries[index]),
              //   );
              // },)
            ),
          ),

        ],
      ),
    );
  }
}
