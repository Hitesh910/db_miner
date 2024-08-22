import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:db_miner/main.dart';
import 'package:db_miner/screen/category/model/category_model.dart';
import 'package:db_miner/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_extend/share_extend.dart';

import '../../../utils/helper/db_helper.dart';
import '../../home/model/quotes_model.dart';

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
      body: ListView.builder(
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
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: -10,
                          color: Colors.white12)
                    ]
                        // image: DecorationImage(
                        //     image: NetworkImage("${model.image![index]}")),
                        ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: MediaQuery.sizeOf(context).height,
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${model.image![index]}"),
                                          fit: BoxFit.cover,
                                          opacity: 0.9)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${model.quotes![index]}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
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
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    DbHelper.helper.insertDB(
                                        quotes: model,
                                        author: model.author![index],
                                        image: model.image![index]);
                                    controller.getQuotes();
                                  },
                                  icon: IconButton(
                                    onPressed: () {

                                    },
                                    icon:
                                   Icon (Icons.favorite,
                                    color: Colors.grey,)
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(icon: Icon(Icons.download),onPressed: () {
                     save();
                              },),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                          text: model.quotes![index]),

                                    );
                                    Fluttertoast.showToast(
                                      msg: 'Text Copied',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16,
                                    );
                                  }, icon: Icon(Icons.copy)),
                              SizedBox(
                                height: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    share();
                                  }, icon: Icon(Icons.share))
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
      return "${dir!.path}.png";
    }


  }

  Future<void> share()
  async {
    RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
    Uint8List img = byteData!.buffer.asUint8List();
    final path = await getApplicationDocumentsDirectory();
    File file = File("${path.path}/img.png");
    file.writeAsBytes(img);
    ShareExtend.share(file.path, "image");
  }
}
