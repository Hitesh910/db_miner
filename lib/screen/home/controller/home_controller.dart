import 'dart:ui';

import 'package:db_miner/utils/helper/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../utils/helper/db_helper.dart';
import '../../favourite/model/db_model.dart';

class HomeController extends GetxController
{
  RxInt i =0.obs;
  RxBool theme = false.obs;
  Rx<Color> isColor = Colors.black.obs;
  RxBool color = false.obs;
  // RxBool theme1 = true.obs;
RxList<DbModel> quotesList = <DbModel>[].obs;

Future<void> getQuotes()
async {
  quotesList.value = await DbHelper.helper.readDB();
}

  void getTheme()
  async {
    SharedHelper helper = SharedHelper();
    bool? theme1 = await helper.getTheme();
    theme.value = theme1 ?? false;
  }
}

// void setTheme(bool theme)
// {
//   SharedHelper helper = SharedHelper();
//   helper.setTheme(theme);
// }
