import 'package:db_miner/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getQuotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: controller.quotesList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                elevation: 2,
                child: Container(
                  height: 300,
                  width: MediaQuery.sizeOf(context).width,
                  child: Text("${controller.quotesList[index].name}"),
                  // color: Colors.black,
                  // margin: EdgeInsets.all(10),
                  // padding: EdgeInsets.all(5),

                  // decoration: BoxDecoration(boxShadow: [
                  //   BoxShadow(
                  //       blurRadius: 10,
                  //       spreadRadius: -10,
                  //       color: Colors.white12)
                  // ]
                  //   // image: DecorationImage(
                  //   //     image: NetworkImage("${model.image![index]}")),
                  // ),
                  // child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     children: [
                  //       Expanded(
                  //         child: Stack(
                  //           children: [
                  //             Container(
                  //               height: MediaQuery.sizeOf(context).height,
                  //               width: MediaQuery.sizeOf(context).width,
                  //               // decoration: BoxDecoration(
                  //               //     borderRadius: BorderRadius.only(
                  //               //         topLeft: Radius.circular(10),
                  //               //         topRight: Radius.circular(10)),
                  //               //     image: DecorationImage(
                  //               //         image: NetworkImage(
                  //               //             "${controller.quotesList[index].}"),
                  //               //         fit: BoxFit.cover,
                  //               //         opacity: 0.9)
                  //               // ),
                  //             ),
                  //             // ClipRRect(
                  //             //   borderRadius: BorderRadius.circular(10),
                  //             //   child: Image.network(
                  //             //     "${model.image![index]}",
                  //             //     fit: BoxFit.cover,
                  //             //     height: MediaQuery
                  //             //         .sizeOf(context)
                  //             //         .height,
                  //             //     width: MediaQuery
                  //             //         .sizeOf(context)
                  //             //         .width,
                  //             //   ),
                  //             // ),
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text(
                  //                     "${controller.quotesList[index].name}",
                  //                 // "${controller.quotesList[index].quotes}",
                  //                     style: TextStyle(
                  //                         fontSize: 18,
                  //                         fontWeight: FontWeight.w500),
                  //                   ),
                  //                   // Align(
                  //                   //     alignment: Alignment.bottomRight,
                  //                   //     child: Text("${controller.quotesList[index].author}"))
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Icon(Icons.favorite),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Icon(Icons.download),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           IconButton(
                  //               onPressed: () {}, icon: Icon(Icons.copy)),
                  //           SizedBox(
                  //             height: 10,
                  //           ),
                  //           IconButton(
                  //               onPressed: () {}, icon: Icon(Icons.share))
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                ),
              ),
              // SizedBox(height: 10,),
            ],
          );
        },
      ),
    );
  }
}
