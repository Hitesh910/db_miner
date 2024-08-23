import 'dart:io';
import 'dart:ui';
import 'package:db_miner/screen/home/model/quotes_model.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;


import 'package:db_miner/main.dart';
import 'package:db_miner/screen/category/model/category_model.dart';
import 'package:db_miner/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/helper/db_helper.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  CategoryModel model = Get.arguments;
  HomeController controller = Get.put(HomeController());
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.category}"),
      ),
      body:
      // Column(
      //   children: [
      //     ElevatedButton(onPressed: () async {
      //     await  save();
      //     }, child: Icon(Icons.add)),
      //     Center(child: Image.asset("assets/images/img1.png"),),
      //   ],
      // )
      Padding(
        padding: const EdgeInsets.all(1),
        child: ListView.builder(
          itemCount: model.quotes!.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed("/detail",arguments: [
                      model.quotes![index],
                      model.author![index],
                      model.image![index],
                    ]);
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                      height: 300,
                      width: MediaQuery.sizeOf(context).width,
                      margin: const EdgeInsets.only(top: 5,bottom: 8),
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: -10,
                            color: Colors.white12)
                      ]
                          // image: DecorationImage(
                          //     image: NetworkImage("${model.image![index]}")),
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.sizeOf(context).height,
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${model.image![index]}"),
                                            fit: BoxFit.cover,
                                            opacity: 0.9)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 15,right: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${model.quotes![index]}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text("${model.author![index]}"))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      HomeModel model1 = HomeModel(
                                        name:  "${model.category![index]}"
                                      );
                                      DbHelper.helper.insertDB(model1);
                                    // await  DbHelper.helper.insertDB(model.category![index]);

                                      // DbHelper.helper.insertDB(
                                      //     quotes: model.quotes![index],
                                      //     author: model.author![index],
                                      //     image: model.image![index]);
                                      controller.getQuotes();
                                    },
                                    icon:
                                     const Icon (Icons.favorite,
                                       color: Colors.grey,)
                                    ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(icon: const Icon(Icons.download),onPressed: () async {
                      await save();
                                },),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                            text:"${ model.quotes![index]} /n -${model.author![index]}"),

                                      );
                            //           Fluttertoast.showToast(
                            //             msg: 'Text Copied',
                            //             toastLength: Toast.LENGTH_SHORT,
                            //             gravity: ToastGravity.BOTTOM,
                            //             timeInSecForIosWeb: 2,
                            //             backgroundColor: Colors.black,
                            //             textColor: Colors.white,
                            //             fontSize: 16,
                            //           );
                                    }, icon: const Icon(Icons.copy)),
                                const SizedBox(
                                  height: 10,
                                ),
                                IconButton(
                                    onPressed: () {
                                      // share();
                                    }, icon: const Icon(Icons.share)),
                               ],
                             )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 10,),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<String> save()
  async {
    RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var bs64 = byteData?.buffer.asUint8List();

    String? path ="${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";

    if(Platform.isAndroid)
    {
      await File("/storage/emulated/0/Download/$path.png").writeAsBytes(bs64!);
      return "/storage/emulated/0/Download/1.png";
    }
    else
    {
      Directory? dir = await getDownloadsDirectory();
      await File("${dir!.path}.png").writeAsBytes(bs64!);
      return "${dir.path}.png";
    }


  }

  // Future<void> share()
  // async {
  //   RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage();
  //   ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
  //   Uint8List img = byteData!.buffer.asUint8List();
  //   final path = await getApplicationDocumentsDirectory();
  //   File file = File("${path.path}/img.png");
  //   file.writeAsBytes(img);
  //   // ShareExtend.share(file.path, "image");
  // }
}
