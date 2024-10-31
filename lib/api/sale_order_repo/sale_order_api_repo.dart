// import 'package:dio/dio.dart';
// import 'package:mmt_mobile/api/sale_order_repo/sale_order_db_repo.dart';
//
// import '../../database/data_object.dart';
// import '../../model/base_single_api_response.dart';
// import '../api_request.dart';
// import '../api_util.dart';
// import '../base_api_repo.dart';
//
//
// class SaleOrderApiRepo extends BaseApiRepo {
//   static final SaleOrderApiRepo instance = SaleOrderApiRepo._();
//
//   // SqlFLiteHelper _helper = SqlFLiteHelper();
//   SaleOrderDBRepo _saleOrderDBRepo;
//
//   SaleOrderApiRepo._() : _saleOrderDBRepo = SaleOrderDBRepo.instance;
//
//
//
//   // Future<List<SaleOrderHeader>> getCustSaleOrder(int customerId) async {
//   //   String writeDate =
//   //       await _saleOrderDBRepo.getCustomerSaleOrderWriteDate(customerId);
//   //   Response response = await apiCall.postMethodCall(
//   //     path: '/post/',
//   //     data: ApiRequest.createRequest(
//   //       action: 'get_sale_order_by_customer',
//   //       whereArgs: [
//   //         {"name": "partner_id", "value": customerId},
//   //         {"name": "write_date", "value": writeDate}
//   //       ],
//   //     ),
//   //   );
//   //
//   //   BaseApiResponse<SaleOrderHeader> baseApiResponse =
//   //       BaseApiResponse.fromJson(response.data);
//   //   await _saleOrderDBRepo.deleteSaleOrder(baseApiResponse);
//   //   return baseApiResponse.data ?? [];
//   //   // baseApiResponse.data!.sort((a, b) => a.writeDate!.compareTo(b.writeDate!));
//   //
//   //   // List<Map<String, dynamic>>? saleOrderJsonList = baseApiResponse.data!
//   //   //     .map((e) => e.copyWith(isUpload: 1).toJsonDB())
//   //   //     .toList();
//   //   //
//   //   // List<Map<String, dynamic>>? saleOrderLineJsonList =
//   //   //     orderLines.map((e) => e.toJson()).toList();
//   // }
//
//   // Future<int> updatePromSaleOrder({required String orderNo}) async {
//   //   Map<String, dynamic> apiRequest =
//   //       ApiRequest.createUpdateOrder(orderNo: orderNo);
//   //
//   //   Response response =
//   //       await postMethodCall( bodyData: apiRequest);
//   //
//   //   final BaseSingleApiResponse baseResponse =
//   //       BaseSingleApiResponse.fromJson(response.data);
//   //
//   //   if (baseResponse.data == null) throw Exception('Something was wring');
//   //
//   //   return baseResponse.data!['id'];
//   // }
//   //
//   // Future<Map<String, dynamic>> deleteSaleOrder(
//   //     {required String orderNo, required int id}) async {
//   //   Map<String, dynamic> data =
//   //       ApiRequest.createDeleteOrder(orderNo: orderNo, id: id);
//   //   Response response =
//   //       await postMethodCall(bodyData: data);
//   //
//   //   return response.data;
//   // }
//
//   // Future<BaseSingleApiResponse> sendApiCall(SaleOrderHeader saleOrderHeader,
//   //     CashCollect? cashCollect, List<Map<String, dynamic>> saleOrderLineJson,
//   //     {String action = 'create_order'}) async {
//   //   // cant delete read only error
//   //   // https://github.com/tekartik/sqflite/issues/140#issuecomment-451881301
//   //   List<Map<String, dynamic>> saleOrderLineJsonTemp = [];
//   //   // remove local hdr id for api
//   //   saleOrderLineJson.forEach((element) {
//   //     Map<String, dynamic> map = Map<String, dynamic>.from(element);
//   //     map.remove('order_no');
//   //     saleOrderLineJsonTemp.add(map);
//   //   });
//   //
//   //   // NumberSeries? noSeries = await DataObject.instance
//   //   //     .getNumberSeries(moduleName: NoSeriesDocType.order.name);
//   //
//   //   NumberSeries? noSeries = MMTApplication.generatedNoSeries;
//   //
//   //   if (noSeries == null) {
//   //     noSeries = await DataObject.instance
//   //         .getNumberSeries(moduleName: NoSeriesDocType.order.name);
//   //   }
//   //
//   //   if (noSeries != null) {
//   //     Response orderResponse = await apiCall.postMethodCall(
//   //       path: '/post/',
//   //       data: ApiRequest.crateOrderReq(
//   //           action: action,
//   //           orderNo: saleOrderHeader.name!,
//   //           orderId: saleOrderHeader.id,
//   //           dateOrder: saleOrderHeader.dateOrder ?? DateTime.now().toString(),
//   //           numberSeries: noSeries,
//   //           note: saleOrderHeader.note,
//   //           orderLinejson: saleOrderLineJsonTemp,
//   //           partnerId: saleOrderHeader.partnerId!,
//   //           fromDirectSale: saleOrderHeader.fromDirectSale ?? false,
//   //           salePerson: MMTApplication.loginResponse!.id!,
//   //           vehicleId: MMTApplication.loginResponse!.currentLocationId,
//   //           cashCollect: cashCollect,
//   //           saleOrderTypeId: saleOrderHeader.saleOrderTypeId,
//   //           saleOrderTypeName: saleOrderHeader.saleOrderTypeName
//   //           // vehicleId: MMTApplication.loginResponse!.deviceId!.vehicleId!.id!,
//   //           ),
//   //     );
//   //     return BaseSingleApiResponse.fromJson(orderResponse.data!);
//   //   } else
//   //     throw Exception('no series not found');
//   // }
//   //
//   // Future<BaseSingleApiResponse> directSaleApiCall(
//   //     {required SaleOrderHeader saleOrderHeader,
//   //     required CashCollect? cashCollect,
//   //     required List<Map<String, dynamic>> saleOrderLineJson}) async {
//   //   Map<String, dynamic> data = await ApiRequest.createDirectSaleRequest(
//   //       saleOrderHeader, cashCollect, saleOrderLineJson);
//   //
//   //   Response response =
//   //       await apiCall.postMethodCall(path: ApiUtils.basePath, data: data);
//   //
//   //   BaseSingleApiResponse baseSingleApiResponse =
//   //       BaseSingleApiResponse.fromJson(response.data);
//   //
//   //   return baseSingleApiResponse;
//   // }
// }
