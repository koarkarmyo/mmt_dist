import 'package:collection/collection.dart';

import '../../src/enum.dart';
import '../partner.dart';

/// id : 13063
/// name : "WH/OUT/06453"
/// partner_id : 11
/// location_id : 21
/// location_dest_id : 5
/// scheduled_date : "2022-10-03 11:31:21"
/// origin : "2SO2210030035"
/// sale_id : 6516
/// batch_id : null
/// delivery_batch : "BATCH/00788"
/// order_amount : 248500.0
/// remark : "Ma Thet Thet Htay"
/// state : "cancel"
/// move_ids_without_package : [{"id":47748,"product_id":78,"product_uom_qty":480.0,"quantity_done":0.0,"product_uom":31,"picking_id":13063,"sale_line_id":23687,"product_name":"[350C] COKE 350ML NEW","product_uom_name":"PCs"},{"id":47749,"product_id":79,"product_uom_qty":84.0,"quantity_done":0.0,"product_uom":31,"picking_id":13063,"sale_line_id":23688,"product_name":"[350O] ORANGE 350ML NEW","product_uom_name":"PCs"},{"id":47750,"product_id":80,"product_uom_qty":36.0,"quantity_done":0.0,"product_uom":31,"picking_id":13063,"sale_line_id":23689,"product_name":"[350L] LIME 350ML NEW","product_uom_name":"PCs"},{"id":47751,"product_id":75,"product_uom_qty":12.0,"quantity_done":0.0,"product_uom":31,"picking_id":13063,"sale_line_id":23690,"product_name":"[200L] LIME 200ML NEW","product_uom_name":"PCs"}]
/// write_date : "2022-10-04 02:02:46.175593"
/// partner_name : "BBB"
/// batch_name : null

enum SaleType { sale, foc , disc, coupon}


class StockPickingModel {
  StockPickingModel({
    this.id,
    this.name,
    this.partnerId,
    this.locationId,
    this.locationDestId,
    this.scheduledDate,
    this.origin,
    this.saleId,
    this.batchId,
    this.deliveryBatch,
    this.isUpload,
    this.orderAmount,
    this.remark,
    this.customer,
    this.state,
    this.moveIdsWithoutPackage,
    this.writeDate,
    this.partnerName,
    this.batchName,
    this.pkPcs,
    this.ward,
    this.township,
    this.phoneNo,
    this.isBackOrder,
    this.dateDone,
    this.isPartial,
  });

  StockPickingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    partnerId = json['partner_id'];
    locationId = json['location_id'];
    locationDestId = json['location_dest_id'];
    scheduledDate = json['scheduled_date'];
    origin = json['origin'];
    saleId = json['sale_id'];
    batchId = json['batch_id'];
    deliveryBatch = json['delivery_batch'];
    orderAmount = json['order_amount'];
    isUpload = json.containsKey("is_upload") ? json['is_upload'] == 1 : true;
    remark = json['remark'];
    state = DeliveryStatus.values
        .firstWhereOrNull((element) => element.name == json['state']);
    if (json['move_ids_without_package'] != null) {
      moveIdsWithoutPackage = [];
      json['move_ids_without_package'].forEach((v) {
        moveIdsWithoutPackage?.add(StockMoveNewModel.fromJson(v));
      });
    }
    writeDate = json['write_date'];
    partnerName = json['partner_name'];
    batchName = json['batch_name'];
    // map['pk_pcs'] = pkPcs;
    // map['ward'] = ward;
    // map['township'] = township;
    // map['phone_no'] = phoneNo;
    pkPcs = json['pk_pcs'];
    ward = json['ward'];
    township = json['township'];
    phoneNo = json['phone_no'];
    dateDone = json['date_done'];
    isBackOrder = json['is_back_order'] == 1;
    isPartial = json['is_partial'] ?? false;
  }

  StockPickingModel.fromJsonDB(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    partnerId = json['partner_id'];
    locationId = json['location_id'];
    locationDestId = json['location_dest_id'];
    scheduledDate = json['scheduled_date'];
    origin = json['origin'];
    saleId = json['sale_id'];
    batchId = json['batch_id'];
    deliveryBatch = json['delivery_batch'];
    orderAmount = json['order_amount'];
    isUpload = json.containsKey("is_upload") ? json['is_upload'] == 1 : true;
    remark = json['remark'];
    state = DeliveryStatus.values
        .firstWhereOrNull((element) => element.name == json['state']);
    if (json['move_ids_without_package'] != null) {
      moveIdsWithoutPackage = [];
      json['move_ids_without_package'].forEach((v) {
        moveIdsWithoutPackage?.add(StockMoveNewModel.fromJson(v));
      });
    }
    writeDate = json['write_date'];
    partnerName = json['partner_name'];
    batchName = json['batch_name'];
    // map['pk_pcs'] = pkPcs;
    // map['ward'] = ward;
    // map['township'] = township;
    // map['phone_no'] = phoneNo;
    pkPcs = json['pk_pcs'];
    ward = json['ward'];
    township = json['township'];
    phoneNo = json['phone_no'];
    dateDone = json['date_done'];
    isBackOrder = json['is_back_order'] == 1;
    isPartial = json['is_partial'] == 1;
  }

  int? id;
  String? name;
  int? partnerId;
  int? locationId;
  int? locationDestId;
  String? scheduledDate;
  String? origin;
  int? saleId;
  int? batchId;
  String? deliveryBatch;
  double? orderAmount;
  String? remark;
  bool? isUpload;
  Partner? customer;
  DeliveryStatus? state;
  List<StockMoveNewModel>? moveIdsWithoutPackage;
  String? writeDate;
  String? partnerName;
  String? batchName;
  String? pkPcs;
  String? ward;
  String? township;
  String? phoneNo;
  bool? isBackOrder;
  String? dateDone;
  bool? isPartial;

  // "pk_pcs": "15/25",
  // "ward": null,
  // "township": null,
  // "phone_no": null,

  StockPickingModel copyWith({
    int? id,
    String? name,
    int? partnerId,
    int? locationId,
    int? locationDestId,
    String? scheduledDate,
    String? origin,
    int? saleId,
    int? batchId,
    Partner? customer,
    String? deliveryBatch,
    bool? isUpload,
    double? orderAmount,
    String? remark,
    DeliveryStatus? state,
    List<StockMoveNewModel>? moveIdsWithoutPackage,
    String? writeDate,
    String? partnerName,
    String? batchName,
    String? pkPcs,
    String? ward,
    String? township,
    String? phoneNo,
    bool? isBackOrder,
    String? dateDone,
    bool? isPartial,
  }) =>
      StockPickingModel(
        id: id ?? this.id,
        name: name ?? this.name,
        partnerId: partnerId ?? this.partnerId,
        locationId: locationId ?? this.locationId,
        isUpload: isUpload ?? this.isUpload,
        locationDestId: locationDestId ?? this.locationDestId,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        origin: origin ?? this.origin,
        saleId: saleId ?? this.saleId,
        batchId: batchId ?? this.batchId,
        customer: customer ?? this.customer,
        deliveryBatch: deliveryBatch ?? this.deliveryBatch,
        orderAmount: orderAmount ?? this.orderAmount,
        remark: remark ?? this.remark,
        state: state ?? this.state,
        moveIdsWithoutPackage:
            moveIdsWithoutPackage ?? this.moveIdsWithoutPackage,
        writeDate: writeDate ?? this.writeDate,
        partnerName: partnerName ?? this.partnerName,
        batchName: batchName ?? this.batchName,
        pkPcs: pkPcs ?? this.pkPcs,
        ward: ward ?? this.ward,
        township: township ?? this.township,
        phoneNo: phoneNo ?? this.phoneNo,
        isBackOrder: isBackOrder ?? this.isBackOrder,
        dateDone: dateDone ?? this.dateDone,
        isPartial: isPartial ?? this.isPartial,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['partner_id'] = partnerId;
    map['location_id'] = locationId;
    map['location_dest_id'] = locationDestId;
    map['scheduled_date'] = scheduledDate;
    map['origin'] = origin;
    map['sale_id'] = saleId;
    map['batch_id'] = batchId;
    map['delivery_batch'] = deliveryBatch;
    map['order_amount'] = orderAmount;
    map['remark'] = remark;
    map['state'] = state?.name;
    // if (moveIdsWithoutPackage != null) {
    //   map['move_ids_without_package'] =
    //       moveIdsWithoutPackage?.map((v) => v.toJson()).toList();
    // }
    map['write_date'] = writeDate;
    map['partner_name'] = partnerName;
    map['batch_name'] = batchName;
    map['pk_pcs'] = pkPcs;
    map['ward'] = ward;
    map['township'] = township;
    map['phone_no'] = phoneNo;
    map['date_done'] = dateDone;
    map['is_back_order'] = isBackOrder;
    map['is_partial'] = isPartial ?? false;
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['partner_id'] = partnerId;
    map['location_id'] = locationId;
    map['location_dest_id'] = locationDestId;
    map['scheduled_date'] = scheduledDate;
    map['origin'] = origin;
    map['is_upload'] = isUpload;
    map['sale_id'] = saleId;
    map['batch_id'] = batchId;
    map['delivery_batch'] = deliveryBatch;
    map['order_amount'] = orderAmount;
    map['remark'] = remark;
    map['state'] = state?.name;
    map['write_date'] = writeDate;
    map['partner_name'] = partnerName;
    map['batch_name'] = batchName;
    map['pk_pcs'] = pkPcs;
    map['ward'] = ward;
    map['township'] = township;
    map['phone_no'] = phoneNo;
    map['date_done'] = dateDone;
    map['is_back_order'] = isBackOrder;
    map['is_partial'] = isPartial ?? false;
    return map;
  }
}

/// id : 47748
/// product_id : 78
/// product_uom_qty : 480.0
/// quantity_done : 0.0
/// product_uom : 31
/// picking_id : 13063
/// sale_line_id : 23687
/// product_name : "[350C] COKE 350ML NEW"
/// product_uom_name : "PCs"

class StockMoveNewModel {
  StockMoveNewModel({
    this.id,
    this.productId,
    this.productUomQty,
    this.quantityDone,
    this.productUom,
    this.pickingId,
    this.isBasePrice,
    this.priceUnit,
    this.bQty,
    this.lQty,
    this.saleLineId,
    this.productName,
    this.productUomName,
    this.saleType,
    this.saleOrderQty,
  });

  StockMoveNewModel.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    productUomQty = json['product_uom_qty'];
    quantityDone = json['quantity_done'];
    productUom = json['product_uom'];
    pickingId = json['picking_id'];
    saleLineId = json['sale_line_id'];
    isBasePrice = json['is_base_price'];
    priceUnit = json['price_unit'];
    productName = json['product_name'];
    productUomName = json['product_uom_name'];
    saleType = SaleType.values
        .firstWhereOrNull((element) => element.name == json['sale_type']);
    saleOrderQty = json['sale_order_qty'];
  }

  StockMoveNewModel.fromJsonDB(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    productUomQty = json['product_uom_qty'];
    quantityDone = json['quantity_done'];
    productUom = json['product_uom'];
    pickingId = json['picking_id'];
    saleLineId = json['sale_line_id'];
    isBasePrice = json['is_base_price'] == 1;
    priceUnit = json['price_unit'];
    productName = json['product_name'];
    productUomName = json['product_uom_name'];
    saleOrderQty = json['sale_order_qty'];
    saleType = SaleType.values
        .firstWhereOrNull((element) => element.name == json['sale_type']);
  }

  int? id;
  int? productId;
  double? productUomQty;
  double? quantityDone;
  int? productUom;
  int? pickingId;
  int? bQty;
  int? lQty;
  int? saleLineId;
  String? productName;
  double? priceUnit;
  bool? isBasePrice;
  String? productUomName;
  String? qtyDoneBL;
  String? uomQtyBL;
  SaleType? saleType;
  double? saleOrderQty;

  StockMoveNewModel copyWith({
    int? id,
    int? productId,
    double? productUomQty,
    double? quantityDone,
    int? productUom,
    int? pickingId,
    double? priceUnit,
    bool? isBasePrice,
    int? saleLineId,
    String? productName,
    String? productUomName,
    SaleType? saleType,
    double? saleOrderQty,
  }) =>
      StockMoveNewModel(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productUomQty: productUomQty ?? this.productUomQty,
        quantityDone: quantityDone ?? this.quantityDone,
        productUom: productUom ?? this.productUom,
        pickingId: pickingId ?? this.pickingId,
        isBasePrice: isBasePrice ?? this.isBasePrice,
        priceUnit: priceUnit ?? this.priceUnit,
        saleLineId: saleLineId ?? this.saleLineId,
        productName: productName ?? this.productName,
        productUomName: productUomName ?? this.productUomName,
        saleType: saleType ?? this.saleType,
        saleOrderQty: saleOrderQty ?? this.saleOrderQty,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['product_uom_qty'] = productUomQty;
    map['quantity_done'] = quantityDone;
    map['product_uom'] = productUom;
    map['picking_id'] = pickingId;
    map['is_base_price'] = isBasePrice;
    map['price_unit'] = priceUnit;
    map['sale_line_id'] = saleLineId;
    map['product_name'] = productName;
    map['product_uom_name'] = productUomName;
    map['sale_type'] = saleType?.name;
    map['sale_order_qty'] = saleOrderQty;
    return map;
  }
}
