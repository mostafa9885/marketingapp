

class SearchModel
{
  bool? status;
  SearchData? data;

  SearchModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] == null ? null : SearchData.fromJson(json['data']);
  }

}

class SearchData
{
  int? currentPage;
  List<ProductData> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  SearchData.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
    if(json['data'] != null)
    {
      json['data'].forEach((v)
      {
        data.add(ProductData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}


class ProductData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;


  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
