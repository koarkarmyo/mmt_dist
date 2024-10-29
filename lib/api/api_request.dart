import 'package:mmt_mobile/database/database_helper.dart';

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

  static createActionRequest(String actionName) async {
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
          "company_id": MMTApplication.loginResponse?.companyId,
          "staff_role_id": MMTApplication.currentUser?.id,
          "location_id": 0,
          "write_date": writeDate,
          "employee_id": MMTApplication.currentUser?.id
        });
  }
}
