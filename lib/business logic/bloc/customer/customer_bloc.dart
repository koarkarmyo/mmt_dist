import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../database/data_object.dart';
import '../../../database/db_constant.dart';
import '../../../model/cust_visit.dart';
import '../../../model/daily_route.dart';
import '../../../model/partner.dart';
import '../../../model/route/route_plan.dart';
import '../../../model/tag.dart';
import '../../../src/mmt_application.dart';
import '../../../ui/widgets/customer_filter_widget.dart';
import '../../../utils/date_time_utils.dart';
import '../../repository/customer_repo/customer_db_repo.dart';
import '../../repository/route_plan_repo/route_plan_db_repo.dart';
import '../bloc_crud_process_state.dart';

part 'customer_event.dart';

part 'customer_state.dart';
//
// class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
//   late DataObject _dataObject = DataObject.instance;
//   // SqlFLiteHelper _helper = SqlFLiteHelper();
//   final CustomerDBRepo _customerDBRepo;
//   final RoutePlanDBRepo _routePlanDBRepo;
//   static List<Partner> _customerList = [];
//
//   CustomerBloc()
//       : _customerDBRepo = CustomerDBRepo.instance,
//         _routePlanDBRepo = RoutePlanDBRepo.instance,
//         super(CustomerState(
//             customers: [], state: BlocCRUDProcessState.initial, errors: {})) {
//     on<CustomerFilterByTeleSale>(_customerFilterByTeleSale);
//     on<CustomerEvent>((event, emit) async {
//       if (event is CustomerFetchEvent) {
//         // await _fetchCustomerProcess(event, emit);
//       }
//       if (event is CustomerCreateEvent) {
//         // await _createCustomer(event, emit);
//       }
//       if (event is CustomerFilterEvent) {
//         await _filterCustomer(event, emit);
//       }
//       if (event is CustomerFilterByNameEvent) {
//         await _filterCustomerByName(event, emit);
//       }
//       if (event is CustomerFetchAllEvent) {
//         await _fetchAllCustomer(event, emit);
//       }
//       if (event is CustomerFilterByRouteEvent) {
//         await _fetchCustomerByRoute(event, emit);
//       }
//     });
//   }
//
//   // _fetchCustomerProcess(
//   //     CustomerFetchEvent event, Emitter<CustomerState> emit) async {
//   //   emit.call(state.copyWith(state: BlocCRUDProcessState.fetching));
//   //   List<Partner> customerList = [];
//     // DailyRoute? _todayRoute = await _dataObject.getTodayRoute();
//     // if (_todayRoute.id != 0) {
//     //   customerList = await _dataObject.getCustomerListWithFilter(
//     //       route_id: _todayRoute.id.toString());
//     //   MMTApplication.todayRoute =
//     //       DailyRoute(id: _todayRoute.id, name: _todayRoute.name);
//     }
//
//     // List<Map<String, dynamic>> jsonList =
//     //     await _helper.readAllData(tableName: DBConstant.resPartnerTable);
//     // List<Customer> customerList = [];
//     // jsonList.forEach((jsonCustomer) {
//     //   customerList.add(Customer.fromJson(jsonCustomer));
//     // });
//     // emit.call(state.copyWith(
//     //     customers: customerList, state: BlocCRUDProcessState.fetchSuccess));
//   // }
//
// // _createCustomer(
// //     CustomerCreateEvent event, Emitter<CustomerState> emit) async {
// //   emit.call(state.copyWith(state: BlocCRUDProcessState.creating));
// //   await Future.delayed(Duration(seconds: 1)).then((value) {
// //     List<Customer> customers = state.customers;
// //     customers.add(event.customer);
// //     emit.call(state.copyWith(
// //         customers: customers, state: BlocCRUDProcessState.createSuccess));
// //   });
// // }
//
//   // _filterCustomer(
//   //     CustomerFilterEvent event, Emitter<CustomerState> emit) async {
//   //   emit(state.copyWith(state: BlocCRUDProcessState.fetching));
//   //
//   //   List<Partner> customerList = await CustomerDBRepo.instance
//   //       .getCustomerListByRoute(
//   //           name: event.searchName,
//   //           custType: event.customerTypeId,
//   //           routeId: event.routeId);
//   //
//   //   // visited customer check
//   //   if (event.customerTypeId != CustomerFilterType.ALL) {
//   //     List<CustVisit> custVisits = await _dataObject.getCustVisit(
//   //         date: DateTimeUtils.yMmDd.format(DateTime.now()));
//   //     // tags
//   //     List<Map<String, dynamic>> tags =
//   //         await _helper.readAllData(tableName: DBConstant.tagAndPartnerTable);
//   //     // tagList.add(Tag(id: json['tag_id'], name: json['name']));
//   //     //
//   //     List<Partner> tempList = [];
//   //     customerList.forEach((customer) {
//   //       List<Map<String, dynamic>> tagJson = tags
//   //           .where((element) => element['partner_id'] == customer.id)
//   //           .toList();
//   //       List<Tag> tagsList = [];
//   //       tagJson.forEach((json) {
//   //         tagsList.add(Tag(id: json['tag_id'], name: json['name']));
//   //       });
//   //       customer.categoryIds = tagsList;
//   //
//   //       CustVisit? custVisit = custVisits.firstWhereOrNull(
//   //           (custVisit) => custVisit.customerId == customer.id);
//   //       // 1 == visited && 0 == missed
//   //       if (event.customerTypeId == CustomerFilterType.VISITED) {
//   //         if (custVisit != null) tempList.add(customer);
//   //       } else {
//   //         if (custVisit == null) tempList.add(customer);
//   //       }
//   //     });
//   //
//   //     customerList.clear();
//   //     customerList.addAll(tempList);
//   //   }
//   //
//   //   // await Future.forEach<Partner>(customerList, (cust) async {
//   //   //   List<Tag> tagList = [];
//   //   //
//   //   //   List<Map<String, dynamic>> jsonList = await _helper.readDataByWhereArgs(
//   //   //       tableName: DBConstant.tagAndPartnerTable,
//   //   //       where: '${DBConstant.partnerId} =?',
//   //   //       whereArgs: [cust.id]);
//   //   //
//   //   //   for (final json in jsonList) {
//   //   //     tagList.add(Tag(id: json['tag_id'], name: json['name']));
//   //   //   }
//   //   //
//   //   //   cust.categoryIds = tagList;
//   //   // });
//   //   _customerList = customerList;
//   //
//   //   emit(state.copyWith(
//   //       customers: customerList, state: BlocCRUDProcessState.fetchSuccess));
//   // }
//
//   // _filterCustomerByName(
//   //     CustomerFilterByNameEvent event, Emitter<CustomerState> emit) async {
//   //   if (event.name.isNotEmpty && _customerList.isNotEmpty) {
//   //     List<Partner> tempList = _customerList
//   //         .where((partner) =>
//   //             partner.name?.toLowerCase().contains(event.name.toLowerCase()) ??
//   //             false)
//   //         .toList();
//   //
//   //     emit(state.copyWith(
//   //         state: BlocCRUDProcessState.fetchSuccess, customers: tempList));
//   //   } else {
//   //     emit(state.copyWith(
//   //         state: BlocCRUDProcessState.fetchSuccess, customers: _customerList));
//   //   }
//   // }
//
//   // _fetchAllCustomer(
//   //     CustomerFetchAllEvent event, Emitter<CustomerState> emit) async {
//   //   emit(state.copyWith(state: BlocCRUDProcessState.fetching));
//   //   List<Partner> customerList = [];
//   //
//   //   customerList = await _customerDBRepo.getCustomer();
//   //
//   //   _customerList = customerList;
//   //   emit(state.copyWith(
//   //       state: BlocCRUDProcessState.fetchSuccess, customers: customerList));
//   // }
//
//   // _fetchCustomerByRoute(
//   //     CustomerFilterByRouteEvent event, Emitter<CustomerState> emit) async {
//   //   emit(state.copyWith(state: BlocCRUDProcessState.fetching));
//   //   List<Partner> customerList = [];
//   //   List<Partner> tempList = [];
//   //   List<RoutePlan> routePlan =
//   //       await _routePlanDBRepo.getRoutePlan(date: event.date);
//   //
//   //   // cust visit
//   //   List<CustVisit> custVisits = await _dataObject.getCustVisit(
//   //       date: DateTimeUtils.yMmDd.format(DateTime.now()));
//   //
//   //   // tags
//   //   List<Map<String, dynamic>> tags =
//   //       await _helper.readAllData(tableName: DBConstant.tagAndPartnerTable);
//   //   List<Partner> customerListTmp = await _customerDBRepo.getCustomer();
//   //
//   //   if (event.customerTypeId == CustomerFilterType.ALL) {
//   //     customerList.addAll(customerListTmp);
//   //   } else {
//   //     if (routePlan.isNotEmpty) {
//   //       routePlan.first.lineIds?.forEach((routeLine) {
//   //         final cust = customerListTmp
//   //             .firstWhereOrNull((element) => routeLine.partnerId == element.id);
//   //         if (cust != null) {
//   //           List<Map<String, dynamic>> tagJson = tags
//   //               .where((element) => element['partner_id'] == cust.id)
//   //               .toList();
//   //           List<Tag> tagsList = [];
//   //           tagJson.forEach((json) {
//   //             tagsList.add(Tag(id: json['tag_id'], name: json['name']));
//   //           });
//   //           cust.categoryIds = tagsList;
//   //
//   //           customerList.add(cust.copyWith(number: routeLine.number));
//   //         }
//   //       });
//   //     }
//   //   }
//   //   // else {
//   //   //   customerList.addAll(customerListTmp);
//   //   // }
//   //
//   //   // visited customer check
//   //   // if (event.customerTypeId != CustomerFilterType.ALL) {
//   //   // tagList.add(Tag(id: json['tag_id'], name: json['name']));
//   //   customerList.forEach((customer) {
//   //     CustVisit? custVisit = custVisits.firstWhereOrNull((custVisit) =>
//   //         custVisit.customerId == customer.id &&
//   //         custVisit.docType == CustVisitTypes.clock_out);
//   //     // 1 == visited && 0 == missed
//   //     if (event.customerTypeId == CustomerFilterType.ALL) {
//   //       tempList.add(customer.copyWith(
//   //           isVisited: custVisit != null, reasonCode: custVisit?.remarks));
//   //     } else {
//   //       if (event.customerTypeId == CustomerFilterType.MISSED) {
//   //         if (custVisit == null) {
//   //           tempList.add(customer.copyWith(isVisited: false));
//   //         }
//   //       } else if (event.customerTypeId == CustomerFilterType.VISITED) {
//   //         if (custVisit != null) {
//   //           tempList.add(customer.copyWith(
//   //               isVisited: true, reasonCode: custVisit.remarks));
//   //         }
//   //       } else {
//   //         tempList.add(customer.copyWith(
//   //             isVisited: custVisit != null, reasonCode: custVisit?.remarks));
//   //       }
//   //     }
//   //     // if (custVisit != null) {
//   //     //   tempList.add(
//   //     //       customer.copyWith(isVisited: true, reasonCode: custVisit.remarks));
//   //     // } else {
//   //     //   tempList.add(customer.copyWith(isVisited: false));
//   //     // }
//   //   });
//   //
//   //   customerList.clear();
//   //   customerList.addAll(tempList);
//   //   // }
//   //   // else {
//   //   //   // tagList.add(Tag(id: json['tag_id'], name: json['name']));
//   //   //   customerList.forEach((customer) {
//   //   //     CustVisit? custVisit = custVisits.firstWhereOrNull(
//   //   //         (custVisit) => custVisit.customerId == customer.id);
//   //   //     // 1 == visited && 0 == missed
//   //   //     if (custVisit != null) {
//   //   //       tempList.add(customer.copyWith(
//   //   //           isVisited: true, reasonCode: custVisit.remarks));
//   //   //     } else {
//   //   //       tempList.add(customer.copyWith(isVisited: false));
//   //   //     }
//   //   //   });
//   //   //
//   //   //   cufstomerList.clear();
//   //   //   customerList.addAll(tempList);
//   //   // }
//   //   _customerList = customerList;
//   //
//   //   emit(state.copyWith(
//   //       state: BlocCRUDProcessState.fetchSuccess, customers: customerList));
//   // }
//
//   // FutureOr<void> _customerFilterByTeleSale(
//   //     CustomerFilterByTeleSale event, Emitter<CustomerState> emit) async {
//   //   emit(state.copyWith(state: BlocCRUDProcessState.fetching));
//   //
//   //   _customerList = await CustomerDBRepo.instance.getCustomer();
//   //
//   //   List<SaleOrderType> saleOrderTypes = await SaleOrderTypeDBRepo()
//   //       .getSaleOrderTypes(saleOrderReqTypes: SaleOrderReqTypes.sale);
//   //   if (saleOrderTypes.isEmpty) {
//   //     emit(state.copyWith(errors: {'error': 'Missing sale order types'}));
//   //     return;
//   //   }
//
//     // SaleOrderType? orderType = saleOrderTypes
//     //     .firstWhereOrNull((element) => element.name == 'Tele Sale');
//     // if (orderType == null) {
//     //   emit(state.copyWith(errors: {'error': 'Missing sale order types'}));
//     //   return;
//     // }
//
//   //   List<CustVisit> custVisitList = await _dataObject.getCustVisit(
//   //       date: DateTimeUtils.yMmDd.format(DateTime.now()), saleOrderTypeId: 1);
//   //   List<Partner> partnerTempList = [];
//   //   if (event.customerFilterType == CustomerFilterType.ALL) {
//   //     _customerList.forEach((cust) {
//   //       CustVisit? custVisit = custVisitList
//   //           .firstWhereOrNull((element) => element.customerId == cust.id);
//   //       partnerTempList.add(cust.copyWith(reasonCode: custVisit?.remarks));
//   //     });
//   //   } else {
//   //     _customerList.forEach((cust) {
//   //       CustVisit? custVisit = custVisitList
//   //           .firstWhereOrNull((element) => element.customerId == cust.id);
//   //       if (event.customerFilterType == CustomerFilterType.MISSED) {
//   //         if (custVisit == null) {
//   //           partnerTempList.add(cust.copyWith(
//   //               isVisited: false, reasonCode: custVisit?.remarks));
//   //         }
//   //       } else {
//   //         if (custVisit != null)
//   //           partnerTempList.add(
//   //               cust.copyWith(isVisited: true, reasonCode: custVisit.remarks));
//   //       }
//   //     });
//   //   }
//   //
//   //   emit(state.copyWith(
//   //       state: BlocCRUDProcessState.fetchSuccess, customers: partnerTempList));
//   // }
// // }
