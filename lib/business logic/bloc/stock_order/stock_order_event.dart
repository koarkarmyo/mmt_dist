part of 'stock_order_bloc.dart';

@immutable
abstract class StockOrderEvent {}

class StockOrderLineAddEvent extends StockOrderEvent {
  final StockOrderLine stockOrderLine;

  StockOrderLineAddEvent({
    required this.stockOrderLine,
  });
}

class StockOrderLineUpdateEvent extends StockOrderEvent {
  final StockOrderLine stockOrderLine;
  final int? position;

  StockOrderLineUpdateEvent({
    required this.stockOrderLine,
    this.position = -1,
  });
}

class StockOrderSendEvent extends StockOrderEvent {
  final String? remark;
  int? locationId;

  StockOrderSendEvent({
    this.remark,
    this.locationId,
  });
}

class StockOrderLocationUpdateEvent extends StockOrderEvent{
  final StockLocation location;

  StockOrderLocationUpdateEvent({required this.location});
}

class StockOrderAddBalanceQty extends StockOrderEvent {
  List<StockOrderLine> stockOrderLineList;
  final List<StockOrderLine>? editCardDetailList;

  StockOrderAddBalanceQty({
    required this.stockOrderLineList,
    this.editCardDetailList,
  });
}

class StockOrderResetEvent extends StockOrderEvent {}
