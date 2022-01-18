
class FAQSModel
{
  bool? status;
  FAQSData? data;

  FAQSModel.fromJson(Map<String, dynamic>json)
  {
    status = json['status'];
    data = json['data'] != null? FAQSData.fromJson(json['data']) : null;
  }
}

class FAQSData
{
  int? currentPage;
  List<AQData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  FAQSData.fromJson(Map<String, dynamic>json)
  {
    currentPage = json['current_page'];
    if(json['data'] != null)
    {
      data = [];
      json['data'].forEach((element)
      {
        data?.add(AQData.fromJson(element));
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

class AQData
{
  int? id;
  String? question;
  String? answer;

  AQData.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}