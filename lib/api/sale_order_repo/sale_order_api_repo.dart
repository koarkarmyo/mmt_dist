import 'package:dio/dio.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_6/sale_order.dart';

import '../../database/data_object.dart';
import '../../database/db_repo/sale_order_db_repo.dart';
import '../../model/base_single_api_response.dart';
import '../../model/number_series.dart';
import '../../src/enum.dart';
import '../../src/mmt_application.dart';
import '../api_request.dart';
import '../base_api_repo.dart';

class SaleOrderApiRepo extends BaseApiRepo {
  static final SaleOrderApiRepo _instance = SaleOrderApiRepo._();

  // SqlFLiteHelper _helper = SqlFLiteHelper();
  SaleOrderDBRepo _saleOrderDBRepo;

  SaleOrderApiRepo._() : _saleOrderDBRepo = SaleOrderDBRepo.instance;

  factory SaleOrderApiRepo() {
    return _instance;
  }

  // Future<List<SaleOrderHeader>> getCustSaleOrder(int customerId) async {
  //   String writeDate =
  //       await _saleOrderDBRepo.getCustomerSaleOrderWriteDate(customerId);
  //   Response response = await apiCall.postMethodCall(
  //     path: '/post/',
  //     data: ApiRequest.createRequest(
  //       action: 'get_sale_order_by_customer',
  //       whereArgs: [
  //         {"name": "partner_id", "value": customerId},
  //         {"name": "write_date", "value": writeDate}
  //       ],
  //     ),
  //   );
  //
  //   BaseApiResponse<SaleOrderHeader> baseApiResponse =
  //       BaseApiResponse.fromJson(response.data);
  //   await _saleOrderDBRepo.deleteSaleOrder(baseApiResponse);
  //   return baseApiResponse.data ?? [];
  //   // baseApiResponse.data!.sort((a, b) => a.writeDate!.compareTo(b.writeDate!));
  //
  //   // List<Map<String, dynamic>>? saleOrderJsonList = baseApiResponse.data!
  //   //     .map((e) => e.copyWith(isUpload: 1).toJsonDB())
  //   //     .toList();
  //   //
  //   // List<Map<String, dynamic>>? saleOrderLineJsonList =
  //   //     orderLines.map((e) => e.toJson()).toList();
  // }

  // Future<int> updatePromSaleOrder({required String orderNo}) async {
  //   Map<String, dynamic> apiRequest =
  //       ApiRequest.createUpdateOrder(orderNo: orderNo);
  //
  //   Response response =
  //       await postMethodCall( bodyData: apiRequest);
  //
  //   final BaseSingleApiResponse baseResponse =
  //       BaseSingleApiResponse.fromJson(response.data);
  //
  //   if (baseResponse.data == null) throw Exception('Something was wring');
  //
  //   return baseResponse.data!['id'];
  // }
  //
  // Future<Map<String, dynamic>> deleteSaleOrder(
  //     {required String orderNo, required int id}) async {
  //   Map<String, dynamic> data =
  //       ApiRequest.createDeleteOrder(orderNo: orderNo, id: id);
  //   Response response =
  //       await postMethodCall(bodyData: data);
  //
  //   return response.data;
  // }

  Future<BaseSingleApiResponse> sendApiCall(SaleOrder saleOrder,
      {String action = 'save_sale_order'}) async {
    // cant delete read only error
    // https://github.com/tekartik/sqflite/issues/140#issuecomment-451881301
    List<Map<String, dynamic>> saleOrderLineJsonTemp = [];
    // remove local hdr id for api
    (saleOrder.orderLines ?? []).forEach((element) {
      Map<String, dynamic> map = Map<String, dynamic>.from(element.toJsonForSaleOrderApi());
      map.remove('order_no');
      saleOrderLineJsonTemp.add(map);
    });

    // NumberSeries? noSeries = await DataObject.instance
    //     .getNumberSeries(moduleName: NoSeriesDocType.order.name);

    // NumberSeries? noSeries = MMTApplication.generatedNoSeries;

    NumberSeries? noSeries = await DataObject.instance
        .getNumberSeries(moduleName: NoSeriesDocType.order.name);

    Response orderResponse = await postApiMethodCall(
      additionalPath: '/api/sync/',
      params: ApiRequest.crateOrderReq(
        action: action,
        orderNo: saleOrder.name!,
        orderId: saleOrder.id,
        // saleOrder.dateOrder ??
        dateOrder: DateTime.now().toString(),
        numberSeries: noSeries,
        note: saleOrder.note,
        orderLinejson: saleOrderLineJsonTemp,
        partnerId: saleOrder.partnerId!,
        fromDirectSale: false,
        salePerson: MMTApplication.currentUser!.id!,
        vehicleId: MMTApplication.currentUser!.defaultLocationId,
        saleOrderTypeId: 0,
        saleOrderTypeName: '',
        // cashCollect: cashCollect,
        // saleOrderTypeId: saleOrder.saleOrderTypeId,
        // saleOrderTypeName: saleOrder.saleOrderTypeName
        // vehicleId: MMTApplication.loginResponse!.deviceId!.vehicleId!.id!,
      ),
    );
    return BaseSingleApiResponse.fromJson(orderResponse.data!);
  }
//
// Future<BaseSingleApiResponse> directSaleApiCall(
//     {required SaleOrderHeader saleOrderHeader,
//     required CashCollect? cashCollect,
//     required List<Map<String, dynamic>> saleOrderLineJson}) async {
//   Map<String, dynamic> data = await ApiRequest.createDirectSaleRequest(
//       saleOrderHeader, cashCollect, saleOrderLineJson);
//
//   Response response =
//       await apiCall.postMethodCall(path: ApiUtils.basePath, data: data);
//
//   BaseSingleApiResponse baseSingleApiResponse =
//       BaseSingleApiResponse.fromJson(response.data);
//
//   return baseSingleApiResponse;
// }
}
