
import '../../src/enum.dart';
import '../stock_picking/stock_picking_model.dart';

class DeliveryReportModel {
  final DeliveryStates deliveryStates;
  final StockPickingModel stockPickingModel;

  DeliveryReportModel({
    required this.deliveryStates,
    required this.stockPickingModel,
  });
}
