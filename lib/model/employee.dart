import 'package:collection/collection.dart';
import 'package:mmt_mobile/model/number_series.dart';
import 'package:mmt_mobile/sync/models/sync_action.dart';

import '../src/mmt_application.dart';
import 'company_id.dart';

class Employee {
  String? name;
  int? id;
  String? phone;
  String? email;
  int? defaultLocationId;
  String? defaultLocationName;
  int? defaultWarehouseId;
  String? defaultWarehouseName;
  int? defaultPricelistId;
  String? defaultPricelistName;
  int? companyId;
  List<SyncAction>? syncActionList;
  bool? useLooseBox;
  List<CompanyId>? companyList;
  List<NumberSeries>? numberSeriesList;

  Employee({
    this.name,
    this.id,
    this.phone,
    this.email,
    this.defaultLocationId,
    this.defaultLocationName,
    this.companyId,
    this.syncActionList,
    this.useLooseBox,
    this.companyList,
    this.numberSeriesList,
    this.defaultPricelistId,
    this.defaultPricelistName,
    this.defaultWarehouseName,
    this.defaultWarehouseId,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    phone = json['phone'];
    phone = json['email'];
    defaultLocationId = json['default_location_id'];
    defaultLocationName = json['default_location_name'];
    defaultWarehouseId = json['default_warehouse_id'];
    defaultWarehouseName = json['default_warehouse_name'];
    defaultPricelistId = json['default_pricelist_id'];
    defaultPricelistName = json['default_pricelist_name'];
    companyId = json['company_id'];
    useLooseBox = json['use_loose_box'];
    if (json['sync_action'] != null) {
      syncActionList = [];
      for (var element in (json['sync_action'] as List<dynamic>)) {
        syncActionList
            ?.add(SyncAction.fromJson(element as Map<String, dynamic>));
      }
    }
    if (json['company_list'] != null) {
      companyList = [];
      for (var companyJson in (json['company_list'] as List<dynamic>)) {
        companyList?.add(CompanyId.fromJson(companyJson));
      }
    }
    if (json['number_series_line'] != null) {
      numberSeriesList = [];
      for (var numberSeries in (json['number_series_line'] as List<dynamic>)) {
        numberSeriesList?.add(NumberSeries.fromJson(numberSeries));
      }
    }

    MMTApplication.selectedCompany = (companyList ?? [])
        .firstWhereOrNull((element) => element.id == companyId);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    map['phone'] = phone;
    map['email'] = email;
    map['default_location_id'] = defaultLocationId;
    map['default_location_name'] = defaultLocationName;
    map['default_warehouse_id'] = defaultWarehouseId;
    map['default_warehouse_name'] = defaultWarehouseName;
    map['company_id'] = companyId;
    map['sync_action'] = syncActionList;
    map['use_loose_box'] = useLooseBox;
    List<Map<String, dynamic>> companyJsonList = [];

    companyList?.forEach(
      (element) {
        companyJsonList.add(element.toJson());
      },
    );
    map['company_list'] = companyJsonList;
    map['default_pricelist_id'] = defaultPricelistId;
    map['default_pricelist_name'] = defaultPricelistName;
    return map;
  }
}

//
//
// LoginResponse loginResponseFromJson(String str) =>
//     LoginResponse.fromJson(json.decode(str));
//
// String loginResponseToJson(LoginResponse data) =>
//     json.encode(data.toJson());
//
// class LoginResponse extends Equatable {
//   int? id;
//   String? name;
//   String? workPhone;
//   String? workEmail;
//   Device? deviceId;
//   StaffRole? staffRole;
//   bool changePrice = false;
//   CompanyId? companyId;
//   int? defaultCompanyId;
//   List<CompanyId>? companyIds;
//   int? mobileUserId;
//
//   // int? staff_role_id;
//   // String? staff_role_name;
//   bool? active;
//   String? writeDate;
//   String? token;
//   String? expire;
//
//   //Vehicle Location
//   int? currentLocationId;
//   String? currentLocationName;
//   List<DailyRoute>? routeId;
//   List<ProductGroup>? employee_prod_groups;
//   List<EmployeeLocation>? employee_locations;
//   List<SyncAction>? syncAction;
//   String? initialDatetime;
//   int? journalId;
//   String? journalName;
//   int? destinationJournalId;
//
//   // String? destinationJournalName;
//   int? currentWarehouse;
//   String? currentWarehouseName;
//   int? warehouseStockLocationId;
//   String? warehouseStockLocationName;
//   CashCollectTypes? cashCollectType;
//   double? saleAreaLimit;
//   bool? allowLocationUpdate;
//   bool? allowRestrictLocation;
//   bool? allowCashIn;
//   bool? allowCashOut;
//
//   LoginResponse(
//       {this.id,
//         this.name,
//         this.workPhone,
//         this.workEmail,
//         this.deviceId,
//         this.staffRole,
//         this.changePrice = false,
//         this.active,
//         this.mobileUserId,
//         this.writeDate,
//         this.token,
//         this.expire,
//         this.currentLocationId,
//         this.currentLocationName,
//         this.routeId,
//         this.employee_prod_groups,
//         this.employee_locations,
//         this.companyId,
//         this.syncAction,
//         this.currentWarehouse,
//         this.currentWarehouseName,
//         this.journalId,
//         this.journalName,
//         this.warehouseStockLocationId,
//         this.warehouseStockLocationName,
//         this.initialDatetime,
//         this.destinationJournalId,
//         this.cashCollectType,
//         this.saleAreaLimit,
//         this.allowLocationUpdate,
//         this.allowRestrictLocation,
//         this.allowCashIn,
//         this.allowCashOut,
//         this.companyIds,
//         this.defaultCompanyId});
//
//   LoginResponse.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     workPhone = json['work_phone'];
//     workEmail = json['work_email'];
//     changePrice = json['change_price'];
//     mobileUserId = json['mobile_user_id'];
//     deviceId =
//     json['device_id'] != null ? Device.fromJson(json['device_id']) : null;
//     staffRole = json['staff_role'] != null
//         ? StaffRole.fromJson(json['staff_role'])
//         : null;
//     active = json['active'];
//     writeDate = json['write_date'];
//     token = json['token'];
//     expire = json['expire'];
//     currentLocationId = json['current_location_id'];
//     currentLocationName = json['current_location_name'];
//     journalId = json['journal_id'];
//     journalName = json['journal_name'];
//     destinationJournalId = json['destination_journal_id'];
//     warehouseStockLocationId = json["warehouse_stock_location_id"];
//     warehouseStockLocationName = json["warehouse_stock_location_name"];
//     currentWarehouse = json["current_warehouse"];
//     currentWarehouseName = json["current_warehouse_name"];
//     initialDatetime = json["initial_datetime"];
//     cashCollectType = CashCollectTypes.values
//         .firstWhereOrNull((e) => e.name == json["cash_collect_type"]);
//     if (json['company_ids'] != null) {
//       List<dynamic> _jsonList = json['company_ids'];
//       companyIds = [];
//       _jsonList.forEach((json) {
//         companyIds?.add(CompanyId.fromJson(json));
//       });
//     } else {
//       companyIds = [CompanyId.fromJson(json['company_id'])];
//     }
// //       List<Map<String,dynamic>> companyList = [{'id' : 1,'name': 'Google'},{'id': 2, 'name': 'Tesla'},{'id':3, 'name': 'Amazon'}];
// // companyList.forEach((element) {
// //   companyIds?.add(CompanyId.fromJson(element));
// // });
//
//     if (json['route_id'] != null) {
//       List<dynamic> _jsonList = json['route_id'];
//       List<DailyRoute> _routeId = [];
//       _jsonList.forEach((json) {
//         _routeId.add(DailyRoute.fromJson(json));
//       });
//       routeId = _routeId;
//     }
//
//     if (json['employee_prod_groups'] != null) {
//       List<dynamic> _jsonList = json['employee_prod_groups'];
//       List<ProductGroup> _productGroupList = [];
//       _jsonList.forEach((json) {
//         _productGroupList.add(ProductGroup.fromJson(json));
//       });
//       employee_prod_groups = _productGroupList;
//     }
//
//     if (json['employee_locations'] != null) {
//       List<dynamic> _jsonList = json['employee_locations'];
//       List<EmployeeLocation> _employeeLocationList = [];
//       _jsonList.forEach((json) {
//         _employeeLocationList.add(EmployeeLocation.fromJson(json));
//       });
//       employee_locations = _employeeLocationList;
//     }
//
//     if (json['sync_action'] != null) {
//       List<SyncAction> _actionList = [];
//       (json['sync_action'] as List).forEach((element) {
//         _actionList.add(SyncAction.fromJson(element));
//       });
//       syncAction = _actionList;
//     }
//
//     if (json['company_id'] != null) {
//       companyId = CompanyId.fromJson(json['company_id']);
//     }
//     allowLocationUpdate = json["allow_location_update"];
//     saleAreaLimit = json["sale_area_limit"];
//     allowRestrictLocation = json['use_restrict_location'];
//     allowCashIn = json['allow_cash_in'];
//     allowCashOut = json['allow_cash_out'];
//     defaultCompanyId = json['default_company_id'];
//   }
//
//   // int? qtyDigit;
//   // int? priceDigit;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['work_phone'] = workPhone;
//     map['work_email'] = workEmail;
//     if (deviceId != null) {
//       map['device_id'] = deviceId?.toJson();
//     }
//     if (staffRole != null) {
//       map['staff_role'] = staffRole?.toJson();
//     }
//     map['mobile_user_id'] = mobileUserId;
//     map['change_price'] = changePrice;
//     map['active'] = active;
//     map['destination_journal_id'] = destinationJournalId;
//     map['write_date'] = writeDate;
//     map['token'] = token;
//     map['expire'] = expire;
//     map['current_location_id'] = currentLocationId;
//     map['current_location_name'] = currentLocationName;
//     map['journal_id'] = journalId;
//     map['journal_name'] = journalName;
//     map['warehouse_stock_location_id'] = warehouseStockLocationId;
//     map['warehouse_stock_location_name'] = warehouseStockLocationName;
//     map['initial_datetime'] = initialDatetime;
//     map["cash_collect_type"] = cashCollectType?.name;
//     map['allow_location_update'] = allowLocationUpdate;
//     map['allow_restrict_location'] = allowRestrictLocation;
//     map["sale_area_limit"] = saleAreaLimit;
//     // map['qty_digit'] = qtyDigit;
//     // map['price_digit'] = priceDigit;
//     map['allow_cash_in'] = allowCashIn;
//     map['allow_cash_out'] = allowCashOut;
//     return map;
//   }
//
//   Map<String, dynamic> toJsonDB() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['work_phone'] = workPhone;
//     map['work_email'] = workEmail;
//     // if (deviceId != null) {
//     //   map['device_id'] = deviceId?.toJson();
//     // }
//     map['staff_role_id'] = staffRole?.id;
//     map['staff_role_name'] = staffRole?.name;
//     map['destination_journal_id'] = destinationJournalId;
//     // if (staffRole != null) {
//     //   map['staff_role'] = converter.jsonEncode(staffRole);
//     // }
//     map['change_price'] = changePrice ? 1 : 0;
//     map['active'] = active == true ? 1 : 0;
//     map['write_date'] = writeDate;
//     map['token'] = token;
//     map['expire'] = expire;
//     map['current_location_id'] = currentLocationId;
//     map['current_location_name'] = currentLocationName;
//     map['journal_id'] = journalId;
//     map['journal_name'] = journalName;
//     map['warehouse_stock_location_id'] = warehouseStockLocationId;
//     map['warehouse_stock_location_name'] = warehouseStockLocationName;
//     map['current_warehouse'] = currentWarehouse;
//     map['current_warehouse_name'] = currentWarehouseName;
//     map['initial_datetime'] = initialDatetime;
//     map['company_id'] = companyId?.id;
//     map['company_name'] = companyId?.name;
//     map["cash_collect_type"] = cashCollectType?.name;
//     map['allow_location_update'] = allowLocationUpdate;
//     map["sale_area_limit"] = saleAreaLimit;
//     map['allow_restrict_location'] = allowRestrictLocation;
//     /* map['qty_digit'] = qtyDigit;
//     map['price_digit'] = priceDigit;*/
//     map['allow_cash_in'] = allowCashIn;
//     map['allow_cash_out'] = allowCashOut;
//     map['mobile_user_id'] = mobileUserId;
//     map['default_company_id'] = defaultCompanyId;
//     return map;
//   }
//
//   LoginResponse.fromJsonDB(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     workPhone = json['work_phone'];
//     mobileUserId = json['mobile_user_id'];
//     workEmail = json['work_email'];
//     destinationJournalId = json['destination_journal_id'];
//     companyId = CompanyId(id: json['company_id'], name: json['company_name']);
//     deviceId =
//     json['device_id'] != null ? Device.fromJson(json['device_id']) : null;
//     // staffRole = json['staff_role'] != null
//     //     ? StaffRole.fromJson(converter.json.decode(json['staff_role']))
//     //     : null;
//     staffRole =
//         StaffRole(id: json['staff_role_id'], name: json['staff_role_name']);
//     cashCollectType = CashCollectTypes.values
//         .firstWhereOrNull((e) => e.name == json["cash_collect_type"]);
//     // map['staff_role_id'] = staffRole?.id;
//     // map['staff_role_name'] = staffRole?.id;
//     active = json['active'] == 1 ? true : false;
//     changePrice = json['change_price'] == 1 ? true : false;
//     writeDate = json['write_date'];
//     token = json['token'];
//     expire = json['expire'];
//     currentLocationId = json['current_location_id'];
//     currentLocationName = json['current_location_name'];
//     journalId = json['journal_id']; // companyId = json['company_id'];
//     journalName = json['journal_name'];
//     warehouseStockLocationId = json["warehouse_stock_location_id"];
//     warehouseStockLocationName = json["warehouse_stock_location_name"];
//     currentWarehouse = json["current_warehouse"];
//     currentWarehouseName = json["current_warehouse_name"];
//     initialDatetime = json["initial_datetime"];
//     allowLocationUpdate = json["allow_location_update"] == 1;
//     allowRestrictLocation = json["allow_restrict_location"] == 1;
//     saleAreaLimit = json["sale_area_limit"];
//     // qtyDigit = json['qty_digit'];
//     // priceDigit = json['price_digit'];
//     allowCashIn = json['allow_cash_in'] == 1;
//     allowCashOut = json['allow_cash_out'] == 1;
//     defaultCompanyId = json['default_company_id'];
//   }
//
//   @override
//   List<Object?> get props => [
//     this.id,
//     this.name,
//     this.workPhone,
//     this.workEmail,
//     this.deviceId,
//     this.staffRole,
//     this.changePrice,
//     this.active,
//     this.writeDate,
//     this.token,
//     this.expire,
//     this.currentLocationId,
//     this.currentWarehouse,
//     this.currentWarehouseName,
//   ];
// }
