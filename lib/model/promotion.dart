import 'package:collection/collection.dart';
import 'package:mmt_mobile/model/product/product_product.dart';

/// id : 1
/// name : "j"
/// start_date : ""
/// end_date : ""
/// write_date : "2025-02-14 04:25:18"
/// reward_line : [{"product_id":60,"product_name":"Smile Wet Tissue 80's Original","qty":0.0,"uom_category_id":23,"uom_category_name":"1x10x200","uom_id":74,"uom_name":"ထုပ်","reward_product_id":60,"reward_product_name":"Smile Wet Tissue 80's Original","reward_qty":0.0,"reward_uom_id":74,"reward_uom_name":"ထုပ်","reward_uom_category_id":23,"reward_uom_category_name":"1x10x200","expense_product_id":59,"expense_product_name":"Smile Wet Tissue 10's Original","buy_x_get_y_id":1,"multiply":true}]
/// min_amount : 0.0
/// dis_type : "amount"
/// amount : 0.0
/// dis_per : 0.0
/// expense_product_id : 36
/// expense_product_name : "%"
enum DiscTypes { amount, dis }

class Promotions {
  Promotions({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.active,
    this.writeDate,
    this.rewardLine,
    this.minAmount,
    this.disType,
    this.amount,
    this.disPer,
    this.expenseProductId,
    this.expenseProductName,
    this.description,
  });

  Promotions.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    active = json['is_active'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    writeDate = json['write_date'];
    if (json['reward_line'] != null) {
      rewardLine = [];
      json['reward_line'].forEach((v) {
        rewardLine?.add(RewardLine.fromJson(v));
      });
    }
    minAmount = json['min_amount'];
    disType = DiscTypes.values
        .firstWhereOrNull((element) => element.name == json['dis_type']);
    amount = json['amount'];
    disPer = json['dis_per'];
    expenseProductId = json['expense_product_id'];
    expenseProductName = json['expense_product_name'];
  }

  int? id;
  String? name;
  String? startDate;
  String? endDate;
  String? writeDate;
  List<RewardLine>? rewardLine;
  double? minAmount;
  DiscTypes? disType;
  double? amount;
  double? disPer;
  int? expenseProductId;
  String? expenseProductName;
  String? description;
  bool? active;

  Promotions copyWith({
    int? id,
    String? name,
    String? startDate,
    String? endDate,
    String? writeDate,
    List<RewardLine>? rewardLine,
    double? minAmount,
    double? refMinAmount,
    DiscTypes? disType,
    double? amount,
    double? disPer,
    int? expenseProductId,
    String? description,
    String? expenseProductName,
  }) =>
      Promotions(
        id: id ?? this.id,
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        writeDate: writeDate ?? this.writeDate,
        rewardLine: rewardLine ?? this.rewardLine,
        minAmount: minAmount ?? this.minAmount,
        disType: disType ?? this.disType,
        amount: amount ?? this.amount,
        disPer: disPer ?? this.disPer,
        description: description ?? this.description,
        expenseProductId: expenseProductId ?? this.expenseProductId,
        expenseProductName: expenseProductName ?? this.expenseProductName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['write_date'] = writeDate;
    if (rewardLine != null) {
      map['reward_line'] = rewardLine?.map((v) => v.toJson()).toList();
    }
    map['min_amount'] = minAmount;
    map['dis_type'] = disType?.name;
    map['amount'] = amount;
    map['dis_per'] = disPer;
    map['expense_product_id'] = expenseProductId;
    map['expense_product_name'] = expenseProductName;
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['write_date'] = writeDate;
    // if (rewardLine != null) {
    //   map['reward_line'] = rewardLine?.map((v) => v.toJson()).toList();
    // }
    map['min_amount'] = minAmount;
    map['dis_type'] = disType?.name;
    map['amount'] = amount;
    map['dis_per'] = disPer;
    map['expense_product_id'] = expenseProductId;
    map['expense_product_name'] = expenseProductName;
    return map;
  }
}

/// product_id : 60
/// product_name : "Smile Wet Tissue 80's Original"
/// qty : 0.0
/// uom_category_id : 23
/// uom_category_name : "1x10x200"
/// uom_id : 74
/// uom_name : "ထုပ်"
/// reward_product_id : 60
/// reward_product_name : "Smile Wet Tissue 80's Original"
/// reward_qty : 0.0
/// reward_uom_id : 74
/// reward_uom_name : "ထုပ်"
/// reward_uom_category_id : 23
/// reward_uom_category_name : "1x10x200"
/// expense_product_id : 59
/// expense_product_name : "Smile Wet Tissue 10's Original"
/// buy_x_get_y_id : 1
/// multiply : true

class RewardLine {
  int? productId;
  ProductProduct? product;
  String? productName;
  String? description;
  double? qty;
  double? refQty;
  int? uomCategoryId;
  String? uomCategoryName;
  int? uomId;
  String? uomName;
  int? rewardProductId;
  String? rewardProductName;
  double? rewardQty;
  int? rewardUomId;
  String? rewardUomName;
  int? rewardUomCategoryId;
  String? rewardUomCategoryName;
  int? expenseProductId;
  String? expenseProductName;
  int? buyXGetYId;
  String? buyXGetYName;
  bool? multiply;

  RewardLine({
    this.productId,
    this.productName,
    this.description,
    this.qty,
    this.refQty,
    this.uomCategoryId,
    this.uomCategoryName,
    this.uomId,
    this.uomName,
    this.rewardProductId,
    this.rewardProductName,
    this.rewardQty,
    this.rewardUomId,
    this.rewardUomName,
    this.rewardUomCategoryId,
    this.rewardUomCategoryName,
    this.expenseProductId,
    this.expenseProductName,
    this.buyXGetYId,
    this.multiply,
    this.buyXGetYName,
  });

  RewardLine.fromJson(dynamic json) {
    productId = json['product_id'];
    productName = json['product_name'];
    description = json['description'];
    qty = json['qty'];
    refQty = json['ref_qty'];
    uomCategoryId = json['uom_category_id'];
    uomCategoryName = json['uom_category_name'];
    uomId = json['uom_id'];
    uomName = json['uom_name'];
    rewardProductId = json['reward_product_id'];
    rewardProductName = json['reward_product_name'];
    rewardQty = json['reward_qty'];
    rewardUomId = json['reward_uom_id'];
    rewardUomName = json['reward_uom_name'];
    rewardUomCategoryId = json['reward_uom_category_id'];
    rewardUomCategoryName = json['reward_uom_category_name'];
    expenseProductId = json['expense_product_id'];
    expenseProductName = json['expense_product_name'];
    buyXGetYId = json['buy_x_get_y_id'];
    multiply = json['multiply'];
  }

  RewardLine copyWith({
    int? productId,
    String? productName,
    String? description,
    double? qty,
    double? refQty,
    int? uomCategoryId,
    String? uomCategoryName,
    int? uomId,
    String? uomName,
    int? rewardProductId,
    String? rewardProductName,
    double? rewardQty,
    int? rewardUomId,
    String? rewardUomName,
    int? rewardUomCategoryId,
    String? rewardUomCategoryName,
    int? expenseProductId,
    String? expenseProductName,
    int? buyXGetYId,
    String? buyXGetYName,
    bool? multiply,
  }) =>
      RewardLine(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        description: description ?? this.description,
        qty: qty ?? this.qty,
        refQty: refQty ?? this.refQty,
        uomCategoryId: uomCategoryId ?? this.uomCategoryId,
        uomCategoryName: uomCategoryName ?? this.uomCategoryName,
        uomId: uomId ?? this.uomId,
        uomName: uomName ?? this.uomName,
        rewardProductId: rewardProductId ?? this.rewardProductId,
        rewardProductName: rewardProductName ?? this.rewardProductName,
        rewardQty: rewardQty ?? this.rewardQty,
        rewardUomId: rewardUomId ?? this.rewardUomId,
        rewardUomName: rewardUomName ?? this.rewardUomName,
        rewardUomCategoryId: rewardUomCategoryId ?? this.rewardUomCategoryId,
        rewardUomCategoryName:
        rewardUomCategoryName ?? this.rewardUomCategoryName,
        expenseProductId: expenseProductId ?? this.expenseProductId,
        expenseProductName: expenseProductName ?? this.expenseProductName,
        buyXGetYId: buyXGetYId ?? this.buyXGetYId,
        buyXGetYName: buyXGetYName ?? this.buyXGetYName,
        multiply: multiply ?? this.multiply,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['description'] = description;
    map['qty'] = qty;
    map['ref_qty'] = refQty;
    map['uom_category_id'] = uomCategoryId;
    map['uom_category_name'] = uomCategoryName;
    map['uom_id'] = uomId;
    map['uom_name'] = uomName;
    map['reward_product_id'] = rewardProductId;
    map['reward_product_name'] = rewardProductName;
    map['reward_qty'] = rewardQty;
    map['reward_uom_id'] = rewardUomId;
    map['reward_uom_name'] = rewardUomName;
    map['reward_uom_category_id'] = rewardUomCategoryId;
    map['reward_uom_category_name'] = rewardUomCategoryName;
    map['expense_product_id'] = expenseProductId;
    map['expense_product_name'] = expenseProductName;
    map['buy_x_get_y_id'] = buyXGetYId;
    map['multiply'] = multiply;
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['description'] = description;
    map['qty'] = qty;
    map['ref_qty'] = qty;
    map['uom_category_id'] = uomCategoryId;
    map['uom_category_name'] = uomCategoryName;
    map['uom_id'] = uomId;
    map['uom_name'] = uomName;
    map['reward_product_id'] = rewardProductId;
    map['reward_product_name'] = rewardProductName;
    map['reward_qty'] = rewardQty;
    map['reward_uom_id'] = rewardUomId;
    map['reward_uom_name'] = rewardUomName;
    map['reward_uom_category_id'] = rewardUomCategoryId;
    map['reward_uom_category_name'] = rewardUomCategoryName;
    map['expense_product_id'] = expenseProductId;
    map['expense_product_name'] = expenseProductName;
    map['buy_x_get_y_id'] = buyXGetYId;
    map['multiply'] = multiply;
    return map;
  }

  RewardLine.fromJsonDB(dynamic json) {
    productId = json['product_id'];
    productName = json['product_name'];
    description = json['description'];
    qty = json['qty'];
    refQty = json['ref_qty'];
    uomCategoryId = json['uom_category_id'];
    uomCategoryName = json['uom_category_name'];
    uomId = json['uom_id'];
    uomName = json['uom_name'];
    rewardProductId = json['reward_product_id'];
    rewardProductName = json['reward_product_name'];
    rewardQty = json['reward_qty'];
    rewardUomId = json['reward_uom_id'];
    rewardUomName = json['reward_uom_name'];
    rewardUomCategoryId = json['reward_uom_category_id'];
    rewardUomCategoryName = json['reward_uom_category_name'];
    expenseProductId = json['expense_product_id'];
    expenseProductName = json['expense_product_name'];
    buyXGetYId = json['buy_x_get_y_id'];
    multiply = json['multiply'] == 1;
  }
}
