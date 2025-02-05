import 'package:mmt_mobile/database/database_helper.dart';

import '../database/data_object.dart';
import '../model/cash_collect.dart';
import '../model/number_series.dart';
import '../model/stock_picking/stock_picking_model.dart';
import '../src/enum.dart';
import '../src/mmt_application.dart';

class ApiRequest {
  static Map<String, dynamic> createRequest(
      {required String action, required Map<String, dynamic> whereArgs}) {
    Map<String, dynamic> json = {
      "name": action,
      "args": whereArgs,
      "token": '${DateTime.now().millisecondsSinceEpoch}'
    };
    return json;
  }

  static Map<String, dynamic> createSyncAction({required String actionName}) {
    return {
      "name": actionName,
      "token": '${DateTime.now().millisecondsSinceEpoch}',
      "args": [
        {"name": "device_id", "value": null}
      ]
    };
  }

  static Future<Map<String, dynamic>> createDeliveryRequest(
      StockPickingModel stockPicking,
      CashCollect? cashCollect,
      List<Map<String, dynamic>> stockMoveJsonList) async {
    NumberSeries? numberSeries = MMTApplication.generatedNoSeries;

    numberSeries ??= await DataObject.instance
        .getNumberSeries(moduleName: NoSeriesDocType.delivery.name);

    return {
      "token": '${DateTime.now().millisecondsSinceEpoch}',
      "name": "save_delivery",
      "args": [
        {
          "name": "device_id",
          "value": {
            // "name": MMTApplication.loginResponse?.deviceId?.id,
            "numberseries_name": numberSeries?.name,
            "number_last": numberSeries?.numberLast,
            "year_last": numberSeries?.yearLast,
            "month_last": numberSeries?.monthLast,
            "day_last": numberSeries?.dayLast
          }
        },
        {"name": "employee_id", "value": MMTApplication.currentUser?.id},
        {"name": "company_id", "value": MMTApplication.selectedCompany?.id},
        {
          "name": "data",
          "value": {
            "id": stockPicking.id,
            "remark": stockPicking.remark,
            "state": stockPicking.state?.name,
            "lines": stockMoveJsonList,
          }
        },
        if (stockPicking.state != DeliveryStatus.cancel)
          {
            "name": "cash_collect",
            "value": {
              "order_id": cashCollect?.orderId,
              "collect_amount": cashCollect?.collectAmount,
              "employee_id": cashCollect?.employeeId
            }
          }
      ]
    };
  }

  static Map<String, dynamic> crateOrderReq({
    required List<Map<String, dynamic>> orderLinejson,
    String action = "create_order",
    required int partnerId,
    required int? orderId,
    required int salePerson,
    required String dateOrder,
    required String orderNo,
    required bool fromDirectSale,
    required int? vehicleId,
    required int? saleOrderTypeId,
    required String? saleOrderTypeName,
    String? note,
    NumberSeries? numberSeries,
    CashCollect? cashCollect,
  }) {
    if (fromDirectSale) action = 'create_direct_sale';

    return {
      "name": "save_sale_order",
      "args": {
        "employee_id": MMTApplication.currentUser?.id,
        "company_id": MMTApplication.currentUser?.companyId,
        "partner_id": partnerId,
        "warehouse_id": MMTApplication.currentUser?.defaultWarehouseId,
        "pricelist_id": MMTApplication.currentUser?.defaultPricelistId,
        "name": orderNo,
        "product_list": orderLinejson,
        "number_series": numberSeries?.toJson(),
      }
    };
  }

  static createActionRequest(String actionName, {int? limit}) async {
    final String? writeDate =
        await DatabaseHelper.instance.getLastWriteDate(actionName: actionName);

    // int locationId = MMTApplication.user.currentLocationId ?? 0;
    // if (actionName == 'get_wh_stock') {
    //   locationId = loginResponse.warehouseStockLocationId ?? 0;
    // }
    //
    // if (actionName == 'get_sale_order_type') {
    //   return ApiRequest.createRequest(
    //       action: 'get_sale_order_type',
    //       whereArgs: [
    //         {"name": "company_id", "value": MMTApplication.selectedCompany?.id},
    //         {"name": "write_date", "value": writeDate}
    //       ]);
    // }
    //
    // if (actionName == 'get_batch_list_by_location') {
    //   return ApiRequest.createRequest(
    //       action: 'get_batch_list_by_location',
    //       whereArgs: [
    //         {"name": "location_id", "value": locationId},
    //         {"name": "company_id", "value": MMTApplication.selectedCompany?.id},
    //         {
    //           "name": "write_date",
    //           "value": writeDate == '2021-03-23 13:34:12'
    //               ? MMTApplication.loginResponse?.initialDatetime
    //               : writeDate
    //         }
    //       ]);
    // }
    //
    // if (actionName == 'get_journal_list') {
    //   return ApiRequest.createRequest(action: 'get_journal_list', whereArgs: [
    //     {"name": "company_id", "value": MMTApplication.selectedCompany?.id},
    //     {"name": "staff_role_id", "value": loginResponse.staffRole?.id},
    //     {"name": "location_id", "value": locationId},
    //     {"name": "write_date", "value": '2021-03-23 13:34:12'},
    //     {"name": "employee_id", "value": MMTApplication.loginResponse?.id},
    //   ]);
    // }
    //
    // if (actionName == 'get_stock_order') {
    //   return ApiRequest.createRequest(action: 'get_stock_order', whereArgs: [
    //     {"name": "request_by", "value": loginResponse.id ?? 0},
    //     {"name": "write_date", "value": writeDate},
    //     {"name": "company_id", "value": loginResponse.companyId?.id},
    //   ]);
    // }
    // if (actionName == 'get_sale_order') {
    //   return ApiRequest.createRequest(
    //       action:
    //       actionName == 'get_wh_stock' ? 'get_inventory_stock' : actionName,
    //       whereArgs: [
    //         // {"name": "device_id", "value": loginResponse.deviceId!.name},
    //         {"name": "staff_role_id", "value": loginResponse.staffRole?.id},
    //         {"name": "location_id", "value": locationId},
    //         {"name": "company_id", "value": MMTApplication.selectedCompany?.id},
    //         {
    //           "name": "write_date",
    //           "value": writeDate == '2021-03-23 13:34:12'
    //               ? MMTApplication.loginResponse?.initialDatetime
    //               : writeDate
    //         },
    //         {"name": "employee_id", "value": MMTApplication.loginResponse?.id},
    //       ]);
    // }
    // if (actionName == 'get_delivery_order') {
    //   return ApiRequest.createRequest(action: actionName, whereArgs: [
    //     {"name": "staff_role_id", "value": loginResponse.staffRole?.id},
    //     {"name": "location_id", "value": locationId},
    //     {"name": "company_id", "value": MMTApplication.selectedCompany?.id},
    //     {
    //       "name": "write_date",
    //       "value": writeDate == '2021-03-23 13:34:12'
    //           ? MMTApplication.loginResponse?.initialDatetime
    //           : writeDate
    //     },
    //     {"name": "employee_id", "value": MMTApplication.loginResponse?.id},
    //   ]);
    // }
    // if (actionName == 'get_account_payment_list') {
    //   return {
    //     "name": "get_account_payment_list",
    //     "args": [
    //       {"name": "write_date", "value": writeDate},
    //       {"name": "company_id", "value": MMTApplication.selectedCompany?.id},
    //       {
    //         "name": "journal_id",
    //         "value": MMTApplication.loginResponse?.journalId
    //       },
    //       {"name": "employee_id", "value": MMTApplication.loginResponse?.id},
    //       // {"name": "is_internal_transfer", "value": true},
    //       // {"name": "payment_type", "value": "outbound"},
    //       // {"name": "from_date", "value": "2023-06-30 13:34:1"},
    //       // {"name": "to_date", "value": "2023-11-30 13:34:1"}
    //     ]
    //   };
    // }
    return ApiRequest.createRequest(
        action:
            actionName == 'get_wh_stock' ? 'get_inventory_stock' : actionName,
        whereArgs:
            // {"name": "company_id", "value": MMTApplication.selectedCompany?.id},
            // {"name": "staff_role_id", "value": MMTApplication.currentUser?.id},
            // {"name": "location_id", "value": 0},
            // {"name": "write_date", "value": writeDate},
            // {"name": "employee_id", "value": MMTApplication.currentUser?.id},
            {
          "company_id": MMTApplication.currentUser?.companyId,
          "staff_role_id": MMTApplication.currentUser?.id,
          "location_id": 0,
          "sync_limit": limit,
          "write_date": writeDate,
          "employee_id": MMTApplication.currentUser?.id
        });
  }
}
