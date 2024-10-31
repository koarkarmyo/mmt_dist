import 'dart:async';

import 'package:dio/dio.dart';
import 'package:collection/collection.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mmt_mobile/sync/sync_utils/sync_utils.dart';

import '../../api/api_error_handler.dart';
import '../../database/db_repo/cust_visit_repo/cust_visit_db_repo.dart';
import '../models/auto_sync_response.dart';
import '../../model/cust_visit.dart';
import '../../src/mmt_application.dart';
import '../../utils/date_time_utils.dart';
import '../../utils/location_utils.dart';
import '../models/sync_group.dart';
import '../models/sync_response.dart';
import '../repo/api_repo/sync_api_repo.dart';
import '../repo/db_repo/sync_action_repo/sync_action_db_repo.dart';

class MainSyncProcess {
  static final SyncApiRepo _syncApiRepo = SyncApiRepo();
  static final SyncActionDBRepo _syncDBRepo = SyncActionDBRepo();
  bool _syncProcessIsRunning = false;
  bool _stopAutoSync = false;
  bool _stopManualSync = false;
  bool _isAutoSync = false;
  late StreamController<AutoSyncResponse> _syncStream;
  static final String successMessage = 'success';
  static final String failMessage = 'fail';
  List<SyncResponse> _autoSyncProcess = [];

  //
  // static SaleOrderDBRepo _saleOrderDBRepo = SaleOrderDBRepo.instance;
  // static SaleOrderApiRepo _saleOrderApiRepo = SaleOrderApiRepo.instance;
  // static CashCollectDBRepo _cashCollectDBRepo = CashCollectDBRepo();
  // static final SqlFLiteHelper _sqlFLiteHelper = SqlFLiteHelper();
  // static final DeliveryDBRepo _deliveryDBRepo = DeliveryDBRepo();
  // static final DeliveryApiRepo _deliveryApiRepo = DeliveryApiRepo();
  static CustVisitDBRepo _custVisitDBRepo = CustVisitDBRepo.instance;

  // static CustVisitApiRepo _custVisitApiRepo = CustVisitApiRepo();

  //
  static Position? _tempPosition;

  // for manual sync
  final List<SyncResponse> _manualSyncProcess = [];

  static final MainSyncProcess instance = MainSyncProcess._();

  MainSyncProcess._() {
    _syncStream = StreamController<AutoSyncResponse>.broadcast();

    Timer.periodic(const Duration(minutes: 4), (timer) async {
      if (_autoSyncProcess.isEmpty) {
        _autoSyncProcess = await getSyncList('MASTER', isManual: false);
      }
      await startAutoSyncProcess(forceStart: false);
    });

    Timer.periodic(const Duration(minutes: 4), (timer) async {
      await _locationSaver();
    });
  }

  Future<List<SyncResponse>> getSyncList(String syncGroup,
      {bool isManual = true}) async {
    List<SyncActionGroup> groups = await _syncDBRepo.getSyncActionGroups();
    SyncActionGroup? group = groups.firstWhereOrNull(
        (element) => element.name?.contains(syncGroup) ?? false);
    return await _syncDBRepo.getActionListByGroup(
        gpId: group?.id ?? 0, isManualSync: isManual);
  }

  Stream<AutoSyncResponse> get syncStream => _syncStream.stream;

  bool get stopAutoSync => _stopAutoSync;

  void setAutoSyncActions(String syncGroup, {bool isImmediate = false}) async {
    List<SyncResponse> process = await getSyncList(syncGroup, isManual: false);
    if (isImmediate) {
      _autoSyncProcess.insertAll(0, process);
    } else {
      _autoSyncProcess.addAll(process);
    }
    if (!_syncProcessIsRunning) await startAutoSyncProcess(forceStart: true);
  }

  Future<void> startAutoSyncProcess({bool? forceStart = false}) async {
    if (_syncProcessIsRunning) {
      // _sendToView(
      //   AutoSyncResponse(
      //       isAutoSync: _isAutoSync,
      //       name: 'Already running',
      //       isFinished: false,
      //       message: failMessage,
      //       progress: 0,
      //       error: 'Already running'),
      // );
      return;
    }
    // print('stopped ::::$_stopAutoSync');
    if (forceStart ?? true) _stopAutoSync = false;
    if (!_stopAutoSync) await _startAutoSync();
  }

  void stopAutoSyncProcess() {
    _stopAutoSync = true;
  }

  void stopManualSyncProcess() {
    _stopManualSync = true;
  }

  Future<void> _startAutoSync() async {
    // is auto sync is running
    _syncProcessIsRunning = true;
    //
    String actionName = '';
    _isAutoSync = true;
    if (_autoSyncProcess.isNotEmpty) {
      actionName = _autoSyncProcess.first.name ?? '';
      print('xxFFxx::${_autoSyncProcess.first.description}');
      _sendToView(_syncResponse(
        name: actionName,
        isFinished: _autoSyncProcess.isEmpty,
      ));
    } else {
      _syncProcessIsRunning = false;
      _sendToView(_syncResponse(
        name: actionName,
        isFinished: _autoSyncProcess.isEmpty,
      ));
      return;
    }

    try {
      /// don't write like this, should be use [completer]
      /// api call
      ///
      SyncProcess syncProcess = await _sendApiRequest(actionName);

      // await Future.delayed(Duration(milliseconds: 500));

      // SyncProcess syncProcess = SyncProcess.Finished;
      if (syncProcess == SyncProcess.Paginated) {
        await _startAutoSync();
      } else if (syncProcess == SyncProcess.Fail) {
        _syncProcessIsRunning = false;
        _sendToView(
          _syncResponse(
              name: actionName,
              error: failMessage,
              message: failMessage,
              isFinished: true),
        );
        return;
      }
      // finish sink stream
      _sendToView(_syncResponse(name: actionName));

      _autoSyncProcess.removeAt(0);

      // send
      _sendToView(
        _syncResponse(
          name: actionName,
          isFinished: _autoSyncProcess.isEmpty,
        ),
      );
      //
    } on DioError catch (e) {
      _syncProcessIsRunning = false;
      _stopAutoSync = false;
      _sendToView(_syncResponse(
          name: actionName,
          error: ApiErrorHandler.createError(e).values.first,
          message: failMessage,
          isFinished: true));
      return;
    } catch (e) {
      _syncProcessIsRunning = false;
      _stopAutoSync = false;
      _sendToView(_syncResponse(
          name: actionName,
          error: e.toString(),
          message: failMessage,
          isFinished: true));
      return;
    }
    // assign auto sync is running or not
    _syncProcessIsRunning = _autoSyncProcess.isNotEmpty;

    // catch action list is empty, It's mean finish and force stop
    if (_autoSyncProcess.isEmpty || _stopAutoSync) {
      _syncProcessIsRunning = false;
      _sendToView(_syncResponse(
        name: actionName,
        message: successMessage,
        isFinished: _autoSyncProcess.isEmpty,
      ));
      return;
    } else {
      // recursive call that method
      await _startAutoSync();
    }
  }

  void _sendToView(AutoSyncResponse response) {
    _syncStream.sink.add(response);
  }

  bool get syncProcessIsRunning => _syncProcessIsRunning;

  AutoSyncResponse _syncResponse(
      {required String name,
      bool isFinished = false,
      String? error,
      double? progress,
      String? message}) {
    return AutoSyncResponse(
        isAutoSync: _isAutoSync,
        name: name,
        error: error ?? '',
        progress: progress ?? 0.0,
        message: message ?? successMessage,
        isFinished: isFinished);
  }

  Future<void> startManualSyncProcess(List<SyncResponse> syncList) async {
    _isAutoSync = false;
    _stopManualSync = false;
    stopAutoSyncProcess();

    // List<SyncResponse> actionList = await getSyncList(syncGroup);

    _manualSyncProcess.clear();
    _manualSyncProcess.addAll(syncList);
    // if (forceStart ?? true) _stopAutoSync = false;
    // if (!_stopAutoSync) await _startAutoSync();
    if (!_syncProcessIsRunning) await _startManualSync(syncList);
  }

  Future<void> _startManualSync(List<SyncResponse> actionList) async {
    if (actionList.length <= 0) {
      return;
    }
    int index = (_manualSyncProcess.length - actionList.length);
    double progress = 0.1;
    int tempLength = _manualSyncProcess.length;
    progress = index / tempLength;

    // is manual sync is running
    _syncProcessIsRunning = true;
    //
    String actionName = '';
    String actionDescription = '';
    _isAutoSync = false;
    if (actionList.isNotEmpty) {
      actionName = actionList.first.name ?? '';
      actionDescription = actionList.first.description ?? '';
      //  I'm running stream
      _sendToView(_syncResponse(name: actionDescription, progress: progress));
    }

    try {
      SyncProcess syncProcess = await _sendApiRequest(actionName);

      if (syncProcess == SyncProcess.Paginated) {
        await _startManualSync(actionList);
      } else if (syncProcess == SyncProcess.Fail) {
        _sendToView(
          _syncResponse(
              name: actionDescription,
              error: failMessage,
              message: failMessage,
              isFinished: true),
        );
        return;
      }

      if (actionList.length <= 0) {
        return;
      }
      actionList.removeAt(0);

      // send
      _sendToView(_syncResponse(
        name: actionDescription,
        progress: actionList.isEmpty ? 1.0 : progress,
        isFinished: actionList.isEmpty,
      ));
    } on DioError catch (e) {
      _syncProcessIsRunning = false;
      _stopAutoSync = false;
      _sendToView(
        _syncResponse(
            name: actionDescription,
            error: ApiErrorHandler.createError(e).values.first,
            message: failMessage,
            isFinished: true),
      );
      return;
    }
    // catch (e) {
    //   _syncProcessIsRunning = false;
    //   _stopAutoSync = false;
    //   _sendToView(_syncResponse(
    //       name: actionDescription,
    //       error: e.toString(),
    //       message: failMessage,
    //       isFinished: true));
    //   return;
    // }
    // assign auto sync is running or not
    _syncProcessIsRunning = actionList.isNotEmpty;

    // catch action list is empty, It's mean finish and force stop
    if (actionList.isEmpty || _stopManualSync) {
      _syncProcessIsRunning = false;
      _stopAutoSync = false;
      return;
    } else {
      if (actionList.length <= 0) {
        return;
      }
      // recursive process
      await _startManualSync(actionList);
    }
  }

//   static Future<bool> _sendSaleOrderSingle() async {
//     List<SaleOrderHeader> saleOrderHdrList =
//         await _saleOrderDBRepo.getDraftSaleOrderHdrs();
//
//     if (saleOrderHdrList.isEmpty) return false;
//
//     if (saleOrderHdrList.isNotEmpty) {
//       SaleOrderHeader saleOrderHdr = saleOrderHdrList.first;
// // qty available check from server
//
// // List<SaleOrderLine> saleOrderLines = await DataObject.instance.getSaleOrderLines(saleOrderHdr.id);
//       List<Map<String, dynamic>> saleOrderLineJson = await _sqlFLiteHelper
//           .readDataByWhereArgs(
//               tableName: DBConstant.saleOrderLineTable,
//               where: '${DBConstant.orderNo} =? ',
//               whereArgs: [saleOrderHdr.name]);
//       List<SaleOrderLine> saleOrderLine = [];
//
//       saleOrderLineJson.forEach((element) {
//         saleOrderLine.add(SaleOrderLine.fromJson(element));
//       });
//
//       final List<Map<String, dynamic>> saleOrderLineJsonApi =
//           saleOrderLine.map((e) => e.toJsonForSaleOrderApi()).toList();
//
//       BaseSingleApiResponse response;
//       Map<String, dynamic> headerJson = {};
//       Map<String, dynamic> cashCollectJson = {};
//
//       if (saleOrderHdr.fromDirectSale == true) {
//         CashCollect? cashCollect =
//             await _cashCollectDBRepo.getCashCollect(saleOrderHdr);
//         response = await _saleOrderApiRepo.directSaleApiCall(
//             saleOrderHeader: saleOrderHdr,
//             cashCollect: cashCollect,
//             saleOrderLineJson: saleOrderLineJsonApi);
//
//         headerJson = response.data!['sale_order'];
//         cashCollectJson = response.data!['cash_collect'];
//       } else {
// //send to server
//         response = await _saleOrderApiRepo.sendApiCall(
//             saleOrderHdr, null, saleOrderLineJsonApi);
//         headerJson = response.data!;
//       }
//
//       SaleOrderHeader responseHeader = SaleOrderHeader.fromJson(headerJson);
//
//       responseHeader.isUpload = 1;
//
//       if (saleOrderHdr.fromDirectSale == true) {
//         CashCollect cashCollect = CashCollect.fromJson(cashCollectJson);
//         cashCollect.orderNo = responseHeader.name;
//         cashCollect.orderId = responseHeader.id;
//
//         responseHeader.fromDirectSale = true;
//
//         bool isUpdated = await _cashCollectDBRepo.updateCashCollect(
//             saleOrderHdr.name, cashCollect);
//       }
//
//       await _saleOrderDBRepo.updateResponseOrder(
//           preOrder: saleOrderHdr, curOrder: responseHeader);
//     }
//     return true;
//   }

//   static Future<bool> _sendDeliveryOrderSingle() async {
//     List<StockPickingModel> stockPickingList =
//         await _deliveryDBRepo.getStockPickingList();
//
// // MMTApplication.printJob('${stockPickingList.length}');
//
//     if (stockPickingList.isEmpty) return false;
// //
//     if (stockPickingList.isNotEmpty) {
//       StockPickingModel stockPickingModel = stockPickingList.first;
//
//       List<StockMoveNewModel> stockMoves =
//           stockPickingModel.moveIdsWithoutPackage ?? [];
//
//       List<Map<String, dynamic>> jsonList =
//           stockMoves.map((e) => e.toJson()).toList();
//
//       BaseSingleApiResponse response;
//       Map<String, dynamic> headerJson = {};
//       Map<String, dynamic> cashCollectJson = {};
//
//       CashCollect? cashCollect;
//
//       if (stockPickingModel.state != DeliveryStatus.cancel) {
//         cashCollect = await _cashCollectDBRepo
//             .getCashCollectByOrderId(stockPickingModel.saleId ?? 0);
//       }
//
//       response = await _deliveryApiRepo.deliverySendApiCall(
//           stockPicking: stockPickingModel,
//           cashCollect: cashCollect,
//           stockMoveJsonList: jsonList);
//
//       headerJson = response.data!['delivery_order'];
//       cashCollectJson = response.data!['cash_collect'];
//
//       StockPickingModel responsePickingModel =
//           StockPickingModel.fromJson(headerJson);
//
//       if (stockPickingModel.state != DeliveryStatus.cancel) {
//         CashCollect responseCashCollect = CashCollect.fromJson(cashCollectJson);
//
//         bool isUpdated = await _cashCollectDBRepo.updateCashCollect(
//             responsePickingModel.origin, responseCashCollect);
//       }
//
//       await _deliveryDBRepo.updateResponsePicking(responsePickingModel);
//     }
//     return true;
//   }

  static Future<void> _locationSaver() async {
    Position position = await LocationUtils.determinePosition();
    if (_tempPosition != null) {
      double meter = Geolocator.distanceBetween(_tempPosition!.latitude,
          _tempPosition!.longitude, position.latitude, position.longitude);
      if (meter > 100) {
        _tempPosition = position;
        await _saveLocationProcess(position);
      }
    } else {
      _tempPosition = position;
      await _saveLocationProcess(position);
    }
  }

//
  static Future<void> _saveLocationProcess(Position position) async {
    try {
      CustVisit custVisit = CustVisit(
          docDate: DateTimeUtils.yMmDdHMS.format(DateTime.now()),
          docType: CustVisitTypes.gps,
          employeeId: MMTApplication.loginResponse?.id ?? 0,
          customerId: 0,
          docNo: 'GPS${DateTime.now().millisecondsSinceEpoch}',
          vehicleId: MMTApplication.loginResponse?.currentLocationId ?? 0,
          deviceId: MMTApplication.loginResponse?.deviceId?.id ?? 0,
          latitude: position.latitude,
          longitude: position.longitude,
          isUpload: 0);

      // I commented this line because this is giving me an error. So PLEASE BE FUCKING SURE to uncomment if you have all the necessary data to save
      // bool dbInsertSuccess = await _custVisitDBRepo.saveCustVisit(custVisit);
    } catch (e) {
      print('location_error : ' + e.toString());
    }
  }

//
//   static Future<bool> _sendCustVisit() async {
// // await SyncUtils.saveCustVisit();
//     List<CustVisit> list = await _custVisitDBRepo.getDraftCustVisitList();
//     if (list.isEmpty) return false;
//
//     final saved = await _custVisitApiRepo.saveCustVisit(list.first);
//     final cust = list.first.copyWith(isUpload: 1);
//     await _sqlFLiteHelper.updateData(
//         table: DBConstant.custVisitTable,
//         where: '${DBConstant.customerId} = ? AND ${DBConstant.docDate} = ?',
//         whereArgs: [cust.customerId, cust.docDate],
//         data: cust.toJson());
//
//     return true;
//   }
//
  Future<SyncProcess> _sendApiRequest(String actionName) async {
    SyncProcess syncProcess = SyncProcess.Finished;
//     // await Future.delayed(const Duration(milliseconds: 1000));
//     // Completer<void> completer = Completer();
//     if (actionName == 'send_sale_order') {
//
//       bool isNeedToSend = await _sendSaleOrderSingle();
//       await Future.delayed(Duration(milliseconds: 300));
//       if (isNeedToSend) syncProcess = SyncProcess.Paginated;
//     } else if (actionName == 'get_delivery_order') {
//       bool isNeedToSend = await _sendDeliveryOrderSingle();
//       await Future.delayed(Duration(milliseconds: 300));
//       if (isNeedToSend) syncProcess = SyncProcess.Paginated;
//       if (syncProcess == SyncProcess.Paginated) {
//         return syncProcess;
//       }
//       Response response = await _syncApiRepo.sendAction(actionName);
//       syncProcess = await SyncUtils.insertToDatabase(
//           actionName: actionName, response: response);
//     } else if (actionName == 'store_cust_visit' ||
//         actionName == 'save_cust_visit') {
//       bool isNeedToSend = await _sendCustVisit();
//       if (isNeedToSend) syncProcess = SyncProcess.Paginated;
//     } else {
    // api call
    Response response = await _syncApiRepo.sendAction(actionName);

    syncProcess = await SyncUtils.insertToDatabase(
        actionName: actionName, response: response);
    // }
    return syncProcess;
  }
}

// don't write like this, should be use [completer]
// await Future.delayed(const Duration(milliseconds: 1000));
// SyncProcess syncProcess = SyncProcess.Finished;
// Completer<void> completer = Completer();
// Timer(const Duration(seconds: 1), () {
//   completer.complete();
// });
// await completer.future;
// Response response =
//     await _syncApiRepo.sendAction(_autoSyncProcess.first.name ?? '');
//
// SyncProcess syncProcess = await SyncUtils.insertToDatabase(
//     actionName: _autoSyncProcess.first.name ?? '', response: response);

//
// enum SyncProcess {
//   autoSyncIdle,
//   autoSyncProcessing,
//   autoSyncFinished,
//   autoSyncFailed,
//   manualSyncIdle,
//   manualSyncProcessing,
//   manualSyncProcessFinished,
//   manualSyncProcessFailed,
// }

// void _checkFinishAndSend(String action, {ValueChanged<bool>? voidCallback}) {
//   if (_autoSyncProcess.isEmpty) {
//     _sendToView(
//       _syncResponse(name: action, isFinished: true),
//     );
//   }
//   voidCallback?.call(_autoSyncProcess.isEmpty);
// }
