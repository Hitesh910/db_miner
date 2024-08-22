// class CategoryModel
// {
//   int? id;
//   String? category;
//   List<dynamic>? quotes;
//   List<dynamic>? authors;
//   List<dynamic>? image;
//
//   CategoryModel({this.id, this.category, this.quotes, this.authors, this.image});
//
//   factory CategoryModel.mapToModel(Map m1)
//   {
//     List l1 = m1['quotes'];
//     List l2 = m1['author'];
//     return CategoryModel(id: m1['id'],category: m1['category'],quotes: l1.map((e) => CategoryModel.mapToModel(e),).toList())
//   }
// }

class CategoryModel {
  int? id;
  String? category;
  List<String>? quotes;
  List<String>? author;
  List<String>? image;
  String? categoryImage;

  CategoryModel({this.id, this.category, this.quotes, this.author, this.image,this.categoryImage});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    quotes = json['quotes'].cast<String>();
    author = json['author'].cast<String>();
    image = json['image'].cast<String>();
    categoryImage = json['imageCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['quotes'] = this.quotes;
    data['author'] = this.author;
    data['image'] = this.image;
    data['imageCategory'] = this.categoryImage;
    return data;
  }
}