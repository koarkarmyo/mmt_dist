import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/database/database_helper.dart';
import 'package:mmt_mobile/database/db_repo/res_partner_repo.dart';

import '../../../database/data_object.dart';
import '../../../model/cust_visit.dart';
import '../../../model/res_partner.dart';
import '../../../model/route/route_plan.dart';
import '../../../ui/widgets/customer_filter_widget.dart';
import '../../../utils/date_time_utils.dart';
import '../../repository/route_plan_repo/route_plan_db_repo.dart';

part 'customer_state.dart';

//

class CustomerCubit extends Cubit<CustomerState> {
  final DataObject _dataObject = DataObject.instance;
  final DatabaseHelper _helper = DatabaseHelper.instance;
  final RoutePlanDBRepo _routePlanDBRepo = RoutePlanDBRepo.instance;

  //
  CustomerCubit()
      : super(CustomerState(
            customerList: [], state: BlocCRUDProcessState.initial));

  fetchCustomers({String? name}) async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    try {
      List<ResPartner> customerList =
          await ResPartnerRepo.instance.getResPartner(name: name);
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          customerList: customerList));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }

  updateCustomerProfile() async {
    emit(state.copyWith(state: BlocCRUDProcessState.updating));
    try {
      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(state: BlocCRUDProcessState.updateSuccess));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.updateFail));
    }
  }

  void fetchCustomerByRoute({
    String? searchName,
    required CustomerFilterType customerTypeId,
    required String date,
  }) async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    List<ResPartner> customerList = [];
    List<ResPartner> tempList = [];
    List<RoutePlan> routePlan = await _routePlanDBRepo.getRoutePlan(date: date);

    // cust visit
    List<CustVisit> custVisits = await _dataObject.getCustVisit(
        date: DateTimeUtils.yMmDd.format(DateTime.now()));

    // tags
    // List<Map<String, dynamic>> tags =
    // await _helper.readAllData(tableName: DBConstant.tagAndPartnerTable);
    List<ResPartner> customerListTmp =
        await ResPartnerRepo.instance.getResPartner(name: searchName);

    // List<Partner> customerListTmp = await _customerDBRepo.getCustomer();

    if (customerTypeId == CustomerFilterType.ALL) {
      customerList.addAll(customerListTmp);
    } else {
      if (routePlan.isNotEmpty) {
        routePlan.first.lineIds?.forEach((routeLine) {
          final cust = customerListTmp
              .firstWhereOrNull((element) => routeLine.partnerId == element.id);
          if (cust != null) {
            // List<Map<String, dynamic>> tagJson = tags
            //     .where((element) => element['partner_id'] == cust.id)
            //     .toList();
            // List<Tag> tagsList = [];
            // tagJson.forEach((json) {
            //   tagsList.add(Tag(id: json['tag_id'], name: json['name']));
            // });
            // cust.categoryIds = tagsList;
            customerList.add(cust.copyWith(number: routeLine.number));
          }
        });
      }
    }
    // else {
    //   customerList.addAll(customerListTmp);
    // }

    // visited customer check
    // if (event.customerTypeId != CustomerFilterType.ALL) {
    // tagList.add(Tag(id: json['tag_id'], name: json['name']));
    customerList.forEach((customer) {
      CustVisit? custVisit = custVisits.firstWhereOrNull((custVisit) =>
          custVisit.customerId == customer.id &&
          custVisit.docType == CustVisitTypes.clock_out);
      // 1 == visited && 0 == missed
      if (customerTypeId == CustomerFilterType.ALL) {
        // reasonCode: custVisit?.remarks
        tempList.add(customer.copyWith(
          isVisited: custVisit != null,
        ));
      } else {
        if (customerTypeId == CustomerFilterType.MISSED) {
          if (custVisit == null) {
            tempList.add(customer.copyWith(isVisited: false));
          }
        } else if (customerTypeId == CustomerFilterType.VISITED) {
          if (custVisit != null) {
            tempList.add(customer.copyWith(isVisited: true));
          }
        } else {
          tempList.add(customer.copyWith(isVisited: custVisit != null));
        }
      }
      // if (custVisit != null) {
      //   tempList.add(
      //       customer.copyWith(isVisited: true, reasonCode: custVisit.remarks));
      // } else {
      //   tempList.add(customer.copyWith(isVisited: false));
      // }
    });

    customerList = [];
    customerList.addAll(tempList);
    // }
    // else {
    //   // tagList.add(Tag(id: json['tag_id'], name: json['name']));
    //   customerList.forEach((customer) {
    //     CustVisit? custVisit = custVisits.firstWhereOrNull(
    //         (custVisit) => custVisit.customerId == customer.id);
    //     // 1 == visited && 0 == missed
    //     if (custVisit != null) {
    //       tempList.add(customer.copyWith(
    //           isVisited: true, reasonCode: custVisit.remarks));
    //     } else {
    //       tempList.add(customer.copyWith(isVisited: false));
    //     }
    //   });
    //
    //   cufstomerList.clear();
    //   customerList.addAll(tempList);
    // }

    emit(state.copyWith(
        state: BlocCRUDProcessState.fetchSuccess, customerList: customerList));
  }
}
