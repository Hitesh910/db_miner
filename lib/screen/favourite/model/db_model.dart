class DbModel
{
  String? name,quotes,author;
  int? id;

  DbModel({this.name, this.quotes, this.author,this.id});

  factory DbModel.mapToModel(Map m1)
  {
    return DbModel(name: m1['name'],quotes: m1['quotes'],author: m1['author'],id: m1['id']);
  }
}