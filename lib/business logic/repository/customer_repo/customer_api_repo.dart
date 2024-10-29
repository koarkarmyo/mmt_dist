// import 'package:dio/dio.dart';
//
// import '../../../api/api_request.dart';
// import '../../../api/base_api_repo.dart';
// import '../../../model/base_single_api_response.dart';
// import '../../../model/partner.dart';
// import '../../../model/route/route_plan.dart';
// import '../route_plan_repo/route_plan_db_repo.dart';
//
// class CustomerApiRepo extends BaseApiRepo {
//   static final CustomerApiRepo instance = CustomerApiRepo._();
//
//   CustomerApiRepo._();
//
//   Future<BaseSingleApiResponse> createCustomer(Partner partner) async {
//     // DailyRoute? dailyRoute = await DataObject.instance.getTodayRoute();
//     DateTime today = DateTime.now();
//     List<RoutePlan> routePlan = await RoutePlanDBRepo.instance
//         .getRoutePlan(date: '${today.year}-${today.month}-${today.day}');
//     // final routeID = dailyRoute.id == 0 ? null : dailyRoute.id;
//     final routeID = routePlan.isEmpty ? null : routePlan.first.id;
//     Map<String, dynamic> data = await ApiRequest.createCustomerRequest(partner,
//         action: "create_customers", route: routeID);
//     Response response =
//         await apiCall.postMethodCall(path: ApiUtils.basePath, data: data);
//     return BaseSingleApiResponse.fromJson(response.data!);
//   }
//
//   Future<void> updateCustomer(Partner partner) async {
//     Map<String, dynamic> data =
//         // ApiRequest.updateCustomerRequest(partner, route: routeID);
//         await ApiRequest.createCustomerRequest(partner,
//             action: "update_customers");
//     Response response =
//         await apiCall.postMethodCall(path: ApiUtils.basePath, data: data);
//   }
// }
