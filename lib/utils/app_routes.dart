import 'package:db_miner/screen/detail/view/detail_screen.dart';
import 'package:db_miner/screen/home/model/quotes_model.dart';
import 'package:db_miner/screen/home/view/home_screen.dart';
import 'package:db_miner/screen/quotes/view/quotes_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> app_routes = {
  "/":(context) => HomeScreen(),
  "/quotes":(context) => QuotesScreen(),
  "/detail":(context) => DetailScreen(),
};