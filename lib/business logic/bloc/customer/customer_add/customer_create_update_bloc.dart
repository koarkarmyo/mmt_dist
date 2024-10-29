import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../api/api_error_handler.dart';
import '../../../../model/base_single_api_response.dart';
import '../../../../model/partner.dart';
import '../../../repository/customer_repo/customer_api_repo.dart';
import '../../../repository/customer_repo/customer_db_repo.dart';
// import 'package:mscm_odoo/business_logic/api_endpoint/api_error_handler.dart';
// import 'package:mscm_odoo/business_logic/repository/customer_repo/customer_api_repo.dart';
// import 'package:mscm_odoo/business_logic/repository/customer_repo/customer_db_repo.dart';
// import 'package:mscm_odoo/models/base_single_api_response.dart';
// import 'package:mscm_odoo/models/partner.dart';

part 'customer_create_update_event.dart';
part 'customer_create_update_state.dart';

// class CustomerCreateUpdateBloc
//     extends Bloc<CustomerCreateUpdateEvent, CustomerCreateUpdateState> {
//   // final CustomerApiRepo _customerApiRepo;
//   // final CustomerDBRepo _customerDBRepo;
//
//   CustomerCreateUpdateBloc()
//       // : _customerApiRepo = CustomerApiRepo.instance,
//       //   _customerDBRepo = CustomerDBRepo.instance,
//         super(CustomerCreateUpdateInitial()) {
//     on<CustomerCreateUpdateEvent>((event, emit) async {
//       if (event is CustomerCreateEvent) {
//         await _createProcess(event, emit);
//       }
//
//       if (event is CustomerUpdateEvent) {
//         await _updateProcess(event, emit);
//       }
//     });
//   }
//
//   _createProcess(CustomerCreateEvent event,
//       Emitter<CustomerCreateUpdateState> emit) async {
//     emit(CustomerCreatingUpdatingState());
//     try {
//       BaseSingleApiResponse response =
//           await _customerApiRepo.createCustomer(event.customer);
//       int? id = response.data?['id'];
//       if (id != null) {
//         Partner customer = event.customer;
//         print('Partner State : ${customer.name}');
//         customer.id = id;
//         await _customerDBRepo.createResPartner(customer);
//       } else {
//         emit(CustomerCreateUpdateFail({'error': 'User create fail!'}));
//       }
//
//       emit(CustomerCreateUpdateSuccess(event.customer));
//     } on DioError catch (e) {
//       emit(CustomerCreateUpdateFail(ApiErrorHandler.createError(e)));
//     } catch (e) {
//       emit(CustomerCreateUpdateFail({'error': 'Something was wrong'}));
//     }
//   }
//
//   _updateProcess(CustomerUpdateEvent event,
//       Emitter<CustomerCreateUpdateState> emit) async {
//     emit(CustomerCreatingUpdatingState());
//     try {
//       await _customerApiRepo.updateCustomer(event.customer);
//       Partner customer = event.customer;
//       // await _customerDBRepo.updateResPartner(customer);
//       emit(CustomerCreateUpdateSuccess(customer));
//     } on DioError catch (e) {
//       emit(CustomerCreateUpdateFail(ApiErrorHandler.createError(e)));
//     } catch (e) {
//       emit(CustomerCreateUpdateFail({'error': 'Something was wrong'}));
//     }
//   }
// }
