// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
//
// import '../../../database/base_db_repo.dart';
// import '../../../database/db_constant.dart';
// import '../../../model/partner.dart';
// import '../../../ui/widgets/customer_filter_widget.dart';
//
//
// class CustomerDBRepo extends BaseDBRepo {
//   static final CustomerDBRepo instance = CustomerDBRepo._();
//
//   CustomerDBRepo._();
//
//   Future<List<Partner>> getCustomerListByRoute(
//       {String name = '%',
//       required int routeId,
//       required CustomerFilterType custType}) async {
//     // String _selectedCustType;
//     // if (custType == CustomerFilterType.ALL) {
//     //   _selectedCustType = '%';
//     // } else if (custType == CustomerFilterType.MISSED) {
//     //   _selectedCustType = '1';
//     // } else {
//     //   _selectedCustType = '0';
//     // }
//     String _selectedRouteId;
//     if (routeId == -1) {
//       _selectedRouteId = '%';
//     } else {
//       _selectedRouteId = routeId.toString();
//     }
//
//     List<Partner> customerList = [];
//     if (routeId == -2) {
//       final List<Map<String, dynamic>> jsonList =
//           await dataObject.filterCustomerByTypeAndNoRoute(
//               customerName: name, routeId: _selectedRouteId);
//
//       List<Partner> customers = [];
//
//       customers =
//           await compute(JsonToObject.changeJsonToObject<Partner>, jsonList);
//
//       // jsonList.forEach((e) => customers.add(Partner.fromJson(e)));
//       customerList = customers;
//     } else {
//       customerList = await dataObject.getCustomerListWithFilter(
//           name: name, route_id: _selectedRouteId);
//     }
//     if (name != '%' && customerList.isNotEmpty)
//       customerList = customerList
//           .where((element) =>
//               element.name?.toLowerCase().contains(name.toLowerCase()) ?? false)
//           .toList();
//     return customerList;
//   }
//
//   Future<List<Partner>> getCustomer({int? id, List<int>? ids}) async {
//     List<Map<String, dynamic>> jsonList = [];
//     List<Partner> customerList = [];
//     if (id == null) {
//       jsonList =
//           await helper.readAllData(tableName: DBConstant.resPartnerTable);
//     } else if (ids != null) {
//       jsonList = await helper.getDataIn(
//           tableName: DBConstant.resPartnerTable,
//           where: DBConstant.id,
//           whereArgs: ids);
//     } else {
//       jsonList = await helper.readAllData(
//         tableName: DBConstant.resPartnerTable,
//         orderBy: DBConstant.name,
//       );
//     }
//
//     jsonList.forEach((json) {
//       customerList.add(Partner.fromJson(json));
//     });
//
//     return customerList;
//   }
//
//   Future<bool> createResPartner(Partner customer) async {
//     bool isCustCreated =
//         await helper.insertData(DBConstant.resPartnerTable, customer.toJson());
//
//     bool isTagInserted = await _insertTagToDB(customer);
//
//     return isCustCreated && isTagInserted;
//   }
//
//   Future<bool> _insertTagToDB(Partner customer) async {
//     bool isInserted = true;
//
//     if (customer.categoryIds?.isNotEmpty == true) {
//       List<Map<String, dynamic>> jsonList = [];
//       for (final tag in customer.categoryIds!) {
//         jsonList.add({
//           DBConstant.tagId: tag.id,
//           DBConstant.name: tag.name,
//           DBConstant.partnerId: customer.id,
//         });
//       }
//
//       isInserted = await helper.insertDataListBath(
//           DBConstant.tagAndPartnerTable, jsonList);
//     }
//
//     return isInserted;
//   }
//
//   Future<bool> updateResPartner(Partner customer) async {
//     bool isCustUpdated = await helper.updateData(
//         table: DBConstant.resPartnerTable,
//         where: '${DBConstant.id} =?',
//         whereArgs: [customer.id],
//         data: customer.toJson());
//
//     await helper.deleteData(DBConstant.tagAndPartnerTable,
//         '${DBConstant.partnerId}=?', [customer.id]);
//
//     bool isTagInserted = await _insertTagToDB(customer);
//
//     return isCustUpdated && isTagInserted;
//   }
// }
