// class QuotesModel
// {
//   int? id;
//   String? category;
//   List<dynamic>? quotes;
//   List<dynamic>? author;
//
//   QuotesModel({this.id, this.category, this.quotes, this.author});
//
//   factory QuotesModel.mapToModel(Map m1)
//   {
//     List l1 = m1['quotes'];
//     List l2 = m1['author'];
//     return QuotesModel(id: m1['id'],category: m1['category'],quotes: m1['quotes'],author: m1['author']);
//   }
// }

class HomeModel
{
  int? id;
  String? name;

  HomeModel({this.id, this.name});

  factory HomeModel.mapToModel(Map m1)
  {
    return HomeModel(id: m1['cid'],name: m1['category']);
  }
}

// class Quetos