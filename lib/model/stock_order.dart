import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mmt_mobile/model/product/product.dart';


/// id : 1
/// request_location_id : 20
/// write_date : "2023-01-04 13:10:46"
/// name : "1STO230104001"
/// date : "2023-01-04 19:40:25"
/// stock_order_line : [{"id":1,"product_id":69,"product_qty":30.0,"product_uom":38,"total_uom":"5/0","product_name":"[1500C] COKE 1500ML","product_uom_name":"PCS"},{"id":2,"product_id":73,"product_qty":60.0,"product_uom":31,"total_uom":"5/0","product_name":"[200C] COKE 200ML","product_uom_name":"PCs"}]
/// employee_name : "SR1- NAING HTWE"
/// employee_id : 2
/// request_location_name : "WH/Output/7B/7422"

StockOrder stoFromJson(String str) => StockOrder.fromJson(json.decode(str));

String stoToJson(StockOrder data) => json.encode(data.toJson());

class StockOrder {
  StockOrder({
    this.id,
    this.requestLocationId,
    this.writeDate,
    this.name,
    this.date,
    this.stockOrderLine,
    this.employeeName,
    this.employeeId,
    this.requestLocationName,
    this.remark,
  });

  StockOrder.fromJson(dynamic json) {
    id = json['id'];
    requestLocationId = json['request_location_id'];
    writeDate = json['write_date'];
    name = json['name'];
    date = json['date'];
    if (json['stock_order_line'] != null) {
      stockOrderLine = [];
      json['stock_order_line'].forEach((v) {
        stockOrderLine?.add(StockOrderLine.fromJson(v));
      });
    }
    employeeName = json['employee_name'];
    employeeId = json['employee_id'];
    requestLocationName = json['request_location_name'];
    remark = json['remark'];
  }

  int? id;
  int? requestLocationId;
  String? writeDate;
  String? name;
  String? date;
  List<StockOrderLine>? stockOrderLine;
  String? employeeName;
  int? employeeId;
  String? requestLocationName;
  String? remark;

  StockOrder copyWith({
    int? id,
    int? requestLocationId,
    String? writeDate,
    String? name,
    String? date,
    List<StockOrderLine>? stockOrderLine,
    String? employeeName,
    int? employeeId,
    String? requestLocationName,
  }) =>
      StockOrder(
        id: id ?? this.id,
        requestLocationId: requestLocationId ?? this.requestLocationId,
        writeDate: writeDate ?? this.writeDate,
        name: name ?? this.name,
        date: date ?? this.date,
        stockOrderLine: stockOrderLine ?? this.stockOrderLine,
        employeeName: employeeName ?? this.employeeName,
        employeeId: employeeId ?? this.employeeId,
        requestLocationName: requestLocationName ?? this.requestLocationName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['request_location_id'] = requestLocationId;
    map['write_date'] = writeDate;
    map['name'] = name;
    map['date'] = date;
    if (stockOrderLine != null) {
      map['stock_order_line'] = stockOrderLine?.map((v) => v.toJson()).toList();
    }
    map['employee_name'] = employeeName;
    map['employee_id'] = employeeId;
    map['request_location_name'] = requestLocationName;
    map['remark'] = remark;
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['request_location_id'] = requestLocationId;
    map['write_date'] = writeDate;
    map['name'] = name;
    map['date'] = date;
    // if (stockOrderLine != null) {
    //   map['stock_order_line'] = stockOrderLine?.map((v) => v.toJson()).toList();
    // }
    map['employee_name'] = employeeName;
    map['employee_id'] = employeeId;
    map['request_location_name'] = requestLocationName;
    map['remark'] = remark;
    return map;
  }
}

/// id : 1
/// product_id : 69
/// product_qty : 30.0
/// product_uom : 38
/// total_uom : "5/0"
/// product_name : "[1500C] COKE 1500ML"
/// product_uom_name : "PCS"

StockOrderLine stockOrderLineFromJson(String str) =>
    StockOrderLine.fromJson(json.decode(str));

String stockOrderLineToJson(StockOrderLine data) => json.encode(data.toJson());

class StockOrderLine {
  //
  StockOrderLine({
    this.id,
    this.productId,
    this.productQty,
    this.productUom,
    this.totalUom,
    this.productName,
    this.productUomName,
    this.orderId,
    this.balanceQty,
    this.bQty,
    this.boxUomId,
    this.lQty,
    this.looseUomId,
    this.balanceQtyRefString,
    this.totalRefQty,
    this.product,
    this.index,
    this.controller
  });

  StockOrderLine.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    productQty = json['product_qty'];
    productUom = json['product_uom'];
    orderId = json['order_id'];
    totalUom = json['total_uom'];
    productName = json['product_name'];
    productUomName = json['product_uom_name'];
  }

  int? id;
  int? productId;
  Product? product;
  int? orderId;
  String? productName;
  double? totalRefQty;
  int? productUom;
  double? balanceQty;
  String? balanceQtyRefString;
  double? bQty;
  int? boxUomId;
  double? lQty;
  int? looseUomId;
  double? productQty;
  String? totalUom;
  String? productUomName;
  double? index;
  TextEditingController? controller;

  Map<String, dynamic> toJson() {
    return {
      'product_id': this.productId,
      'product_qty': this.totalRefQty,
      'product_uom': this.productUom,
    };
    // map['id'] = id;
    // map['product_id'] = productId;
    // map['product_qty'] = productQty;
    // map['product_uom'] = productUom;
    // map['total_uom'] = totalUom;
    // map['product_name'] = productName;
    // map['product_uom_name'] = productUomName;
    // return map;
  }

  Map<String, dynamic> toJsonDB() {
    return {
      'id': this.id,
      'product_id': this.productId,
      'product_name': this.productName,
      'order_id': this.orderId,
      'product_qty': this.totalRefQty ?? this.productQty,
      'product_uom': this.productUom,
      'product_uom_name': this.productUomName,
      'total_uom': this.totalUom,
    };
  }

  StockOrderLine copyWith({
    int? id,
    int? productId,
    Product? product,
    int? orderId,
    String? productName,
    double? totalRefQty,
    int? productUom,
    double? balanceQty,
    String? balanceQtyRefString,
    double? bQty,
    int? boxUomId,
    double? lQty,
    int? looseUomId,
    double? productQty,
    String? totalUom,
    String? productUomName,
    double? index,
  }) {
    return StockOrderLine(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      product: product ?? this.product,
      orderId: orderId ?? this.orderId,
      productName: productName ?? this.productName,
      totalRefQty: totalRefQty ?? this.totalRefQty,
      productUom: productUom ?? this.productUom,
      balanceQty: balanceQty ?? this.balanceQty,
      balanceQtyRefString: balanceQtyRefString ?? this.balanceQtyRefString,
      bQty: bQty ?? this.bQty,
      boxUomId: boxUomId ?? this.boxUomId,
      lQty: lQty ?? this.lQty,
      looseUomId: looseUomId ?? this.looseUomId,
      productQty: productQty ?? this.productQty,
      totalUom: totalUom ?? this.totalUom,
      productUomName: productUomName ?? this.productUomName,
      index: index ?? this.index,
      controller: controller
    );
  }
}
