class StockMove {
  int? id;
  String? productName;

  StockMove.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    productName = data['product_name'];
  }
}
