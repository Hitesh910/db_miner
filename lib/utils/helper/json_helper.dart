import 'dart:convert';

import 'package:flutter/services.dart';

import '../../screen/category/model/category_model.dart';

class JsonHelper {
  static JsonHelper helper = JsonHelper._();
   JsonHelper._();
  Future<List<CategoryModel>> getQuotes() async {
    var data = await rootBundle.loadString("assets/json/quotes.json");
    List json = jsonDecode(data);
    List<CategoryModel> model =
        json.map((e) => CategoryModel.fromJson(e)).toList();
    return model;
  }
}
