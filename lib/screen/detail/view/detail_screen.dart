import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'dart:ui';

import 'package:db_miner/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List l1 = Get.arguments;
  HomeController controller = Get.put(HomeController());
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Set a wallpaper"),
                  onTap: () {},
                ),
                PopupMenuItem(child: Text("Download"),
                onTap: () async {
                await  save();
                },)
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: RepaintBoundary(
                key: globalKey,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("${l1[2]}"), fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => Text(
                                  "${l1[0]}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: controller.isColor.value,
                                      fontFamily: "${controller.isFont.value}"),
                                )),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${l1[1]}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
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

            Row(
              children: [
                IconButton(
                    onPressed: () {
                      controller.isOn.value = !controller.isOn.value;
                    },
                    icon: const Icon(Icons.add)),
                IconButton(
                    onPressed: () {
                      controller.isOn.value = !controller.isOn.value;
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
            Obx(
              () => Visibility(
                visible: controller.isOn.value,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                    Colors.primaries.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          controller.isColor.value = Colors.primaries[index];
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.all(5),
                          decoration:
                              BoxDecoration(color: Colors.primaries[index]),
                        ),
                      );
                    },
                  )
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
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.isOn.value,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                    controller.fontList.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          controller.isFont.value = controller.fontList[index];
                          // controller.isColor.value = Colors.primaries[index];
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.all(5),
                          // decoration: BoxDecoration(color: Colors.primaries[index]),
                          child: Text("${controller.fontList[index]}"),
                        ),
                      );
                    },
                  )
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Object?> save() async {
    {
      RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      var bs64 = byteData?.buffer.asUint8List();



      controller.path.value = "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";

      if (Platform.isAndroid) {
        await File("/storage/emulated/0/Download/${controller.path.value}.png").writeAsBytes(bs64!);
        return "/storage/emulated/0/Download/1.png";
      } else {
        Directory? dir = await getDownloadsDirectory();
        await File("${dir!.path}.png").writeAsBytes(bs64!);
        return "${dir.path}.png";
      }
    }
  }
}
