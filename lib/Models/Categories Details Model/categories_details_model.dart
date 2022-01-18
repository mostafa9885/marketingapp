

class CategoriesDetailModel
{
  bool? status;
  Data? data;

  CategoriesDetailModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data
{
  int? currentPage;
  List<DataCategories>? Pdata;
  String? firstPageUrl;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? total;


  Data.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
    Pdata = [];
    json['data'].forEach((element)
    {
      Pdata!.add(DataCategories.fromJson(element));
    });
    firstPageUrl = json['first_page_url'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    total = json['total'];
  }


}

class DataCategories {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  DataCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}