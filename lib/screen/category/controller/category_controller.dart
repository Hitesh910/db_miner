import 'package:get/get.dart';

import '../../../utils/helper/json_helper.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController
{
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  // RxList quotesList = [
  //   {"name": "","image":""}
  // ].obs;

  Future<void> getData()
  async {
    categoryList.value = await JsonHelper.helper.getQuotes()??[];
  }
}