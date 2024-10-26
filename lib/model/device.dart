import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mmt_mobile/model/vehicle.dart';
import 'package:mmt_mobile/model/warehouse.dart';

import 'number_series.dart';


/// id : 1
/// name : "v01"
/// version_no : "1"
/// system_date : "2022-03-17"
/// date_format : "%d/%m/%Y"
/// time_format : "%H:%M:%S"
/// header : "Test Header"
/// footer : "Test Footer"
/// route_id : [{"id":1,"name":"V01 Thursday Route"},{"id":2,"name":"V01 Friday Route"}]
/// warehouse_id : {"id":1,"name":"EAC WH"}
/// vehicle_id : {"id":2,"name":"3R/3234"}
/// solution_id : "sale"
/// logo : "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"

Device deviceIdFromJson(String str) => Device.fromJson(json.decode(str));

String deviceIdToJson(Device data) => json.encode(data.toJson());

class Device extends Equatable {
  Device({
    this.id,
    this.name,
    this.versionNo,
    this.systemDate,
    this.dateFormat,
    this.timeFormat,
    this.header,
    this.footer,
    // this.routeId,
    this.warehouseId,
    this.vehicleId,
    this.useLooseUom,
    this.solutionId,
    this.requiredClockinPhoto,
    this.logo,
    this.checkAvailableQuantity,
    this.qtyDigit,
    this.priceDigit,
    this.useLooseBox,
    this.priceListId,
  });

  Device.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    versionNo = json['version_no'];
    systemDate = json['system_date'];
    dateFormat = json['date_format'];
    timeFormat = json['time_format'];
    useLooseUom = json['use_loose_uom'];
    header = json['header'];
    requiredClockinPhoto = json['required_clockin_photo'];
    checkPromo = json['check_promo'];
    footer = json['footer'];
    priceListId = json['pricelist_id'];
    // if (json['route_id'] != null) {
    //   routeId = [];
    //   json['route_id'].forEach((v) {
    //     routeId?.add(DailyRoute.fromJson(v));
    //   });
    // }
    checkAvailableQuantity = json['check_available_quantity'];
    if (json['numberseries_ids'] != null) {
      numberseriesIds = <NumberSeries>[];
      json['numberseries_ids'].forEach((v) {
        numberseriesIds!.add(new NumberSeries.fromJson(v));
      });
    }
    warehouseId = json['warehouse_id'] != null
        ? Warehouse.fromJson(json['warehouse_id'])
        : null;
    vehicleId = json['vehicle_id'] != null
        ? Vehicle.fromJson(json['vehicle_id'])
        : null;
    solutionId = json['solution_id'];
    logo = json['logo'];
    qtyDigit = json['qty_digit'];
    priceDigit = json['price_digit'];
    checkAvailableQuantity = json['check_available_quantity'];
    useLooseBox = json['use_loose_box'];
  }

  int? id;
  String? name;
  String? versionNo;
  String? systemDate;
  String? dateFormat;
  String? timeFormat;
  String? header;
  bool? useLooseUom;
  bool? useLooseBox;
  bool? checkAvailableQuantity;
  String? footer;

  // List<DailyRoute>? routeId;
  Warehouse? warehouseId;
  Vehicle? vehicleId;
  String? solutionId;
  String? logo;
  int? qtyDigit;
  int? priceDigit;
  bool? requiredClockinPhoto;
  List<NumberSeries>? numberseriesIds;
  bool? checkPromo;
  int? priceListId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['required_clockin_photo'] = requiredClockinPhoto;
    map['version_no'] = versionNo;
    map['system_date'] = systemDate;
    map['date_format'] = dateFormat;
    map['time_format'] = timeFormat;
    map['header'] = header;
    map['footer'] = footer;
    map['use_loose_uom'] = useLooseUom;
    map['check_available_quantity'] = checkAvailableQuantity;
    map['check_promo'] = checkPromo;
    map['pricelist_id'] = priceListId;
    // if (routeId != null) {
    //   map['route_id'] = routeId?.map((v) => v.toJson()).toList();
    // }
    if (this.numberseriesIds != null) {
      map['numberseries_ids'] =
          this.numberseriesIds!.map((v) => v.toJson()).toList();
    }
    if (warehouseId != null) {
      map['warehouse_id'] = warehouseId?.toJson();
    }
    if (vehicleId != null) {
      map['vehicle_id'] = vehicleId?.toJson();
    }
    map['solution_id'] = solutionId;
    map['logo'] = logo;
    map['qty_digit'] = qtyDigit;
    map['price_digit'] = priceDigit;
    map['use_loose_box'] = useLooseBox;
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['version_no'] = versionNo;
    map['system_date'] = systemDate;
    map['date_format'] = dateFormat;
    map['time_format'] = timeFormat;
    map['header'] = header;
    map['footer'] = footer;
    map['required_clockin_photo'] = requiredClockinPhoto == true ? 1 : 0;
    map['check_available_quantity'] = checkAvailableQuantity;
    map['check_promo'] = checkPromo == true ? 1 : 0;
    map['use_loose_uom'] = useLooseUom;
    if (warehouseId != null) {
      map['warehouse_id'] = warehouseId?.id;
      map['warehouse_name'] = warehouseId?.name;
    }
    if (vehicleId != null) {
      map['vehicle_id'] = vehicleId?.id;
      map['vehicle_name'] = vehicleId?.name;
    }
    if (map['numberseries_ids'] != null) {
      numberseriesIds = <NumberSeries>[];
      map['numberseries_ids'].forEach((v) {
        numberseriesIds!.add(new NumberSeries.fromJson(v));
      });
    }
    map['solution_id'] = solutionId;
    map['logo'] = logo;
    map['pricelist_id'] = priceListId;
    map['qty_digit'] = qtyDigit;
    map['price_digit'] = priceDigit;
    map['use_loose_box'] = useLooseBox;
    return map;
  }

  Device.fromJsonDB(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    versionNo = json['version_no'];
    systemDate = json['system_date'];
    dateFormat = json['date_format'];
    timeFormat = json['time_format'];
    header = json['header'];
    footer = json['footer'];
    checkPromo = json['check_promo'] == 0 ? false : true;
    useLooseUom = json['use_loose_uom'] == 0 ? false : true;
    checkAvailableQuantity =
        json['check_available_quantity'] == 0 ? false : true;
    requiredClockinPhoto = json['required_clockin_photo'] == 0 ? false : true;
    warehouseId?.id = json['warehouse_id'];
    warehouseId?.name = json['warehouse_name'];
    Vehicle vehicleT =
        Vehicle(id: json['vehicle_id'], name: json['vehicle_name']);
    vehicleId = vehicleT;
    solutionId = json['solution_id'];
    logo = json['logo'];
    qtyDigit = json['qty_digit'];
    priceDigit = json['price_digit'];
    useLooseBox = json['use_loose_box'];
    priceListId = json['pricelist_id'];
  }

  @override
  List<Object?> get props => [
        this.id,
        this.name,
        this.versionNo,
        this.systemDate,
        this.dateFormat,
        this.useLooseUom,
        this.timeFormat,
        this.header,
        this.footer,
        // this.routeId,
        this.warehouseId,
        this.vehicleId,
        this.requiredClockinPhoto,
        this.solutionId,
        this.logo,
        this.checkPromo,
        this.checkAvailableQuantity,
        this.qtyDigit,
        this.priceDigit
      ];
}
