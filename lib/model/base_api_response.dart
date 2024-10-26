class BaseApiResponse<T> {
  List<T>? data;
  String? error;

  BaseApiResponse({
    this.data,
    this.error,
  });

  BaseApiResponse.fromJson(Map<String,dynamic> json, { required T Function(Map<String,dynamic>) fromJson}) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(fromJson(v));
      });
    }
    //   if (T == SyncResponse) {
    //     json['data'].forEach((v) {
    //       data?.add(SyncResponse.fromJson(v) as T);
    //     });
    //   } else if (T == Partner) {
    //     json['data'].forEach((v) {
    //       data?.add(Partner.fromJson(v) as T);
    //     });
    //   } else if (T == DailyRouteDetail) {
    //     json['data'].forEach((v) {
    //       data?.add(DailyRouteDetail.fromJson(v) as T);
    //     });
    //   } else if (T == Product) {
    //     json['data'].forEach((v) {
    //       data?.add(Product.fromJson(v) as T);
    //     });
    //   } else if (T == Dashboard) {
    //     json['data'].forEach((v) {
    //       data?.add(Dashboard.fromJson(v) as T);
    //     });
    //   } else if (T == Category) {
    //     json['data'].forEach((v) {
    //       data?.add(Category.fromJson(v) as T);
    //     });
    //   } else if (T == PriceList) {
    //     json['data'].forEach((v) {
    //       data?.add(PriceList.fromJson(v) as T);
    //     });
    //   } else if (T == CustomerRegularSaleProduct) {
    //     json['data'].forEach((v) {
    //       data?.add(CustomerRegularSaleProduct.fromJson(v) as T);
    //     });
    //   } else if (T == StockLoadingModel) {
    //     json['data'].forEach((v) {
    //       data?.add(StockLoadingModel.fromJson(v) as T);
    //     });
    //   } else if (T == QtyCheckResponse) {
    //     json['data'].forEach((v) {
    //       data?.add(QtyCheckResponse.fromJson(v) as T);
    //     });
    //   } else if (T == int) {
    //     json['data'].forEach((v) {
    //       data?.add(v as T);
    //     });
    //   } else if (T == SaleOrderHeader) {
    //     json['data']
    //         .forEach((v) => data?.add(SaleOrderHeader.fromJson(v) as T));
    //   } else if (T == VehicleInventoryModel) {
    //     json['data']
    //         .forEach((v) => data?.add(VehicleInventoryModel.fromJson(v) as T));
    //   } else if (T == Invoice) {
    //     json['data'].forEach((v) => data?.add(Invoice.fromJson(v) as T));
    //   } else if (T == RoutePlan) {
    //     json['data'].forEach((v) => data?.add(RoutePlan.fromJson(v) as T));
    //   } else if (T == Return) {
    //     json['data'].forEach((v) => data?.add(Return.fromJson(v) as T));
    //   } else if (T == VehicleLocation) {
    //     json['data']
    //         .forEach((v) => data?.add(VehicleLocation.fromJson(v) as T));
    //   } else if (T == Township) {
    //     json['data'].forEach((v) => data?.add(Township.fromJson(v) as T));
    //   } else if (T == PartnerGrade) {
    //     json['data'].forEach((v) => data?.add(PartnerGrade.fromJson(v) as T));
    //   } else if (T == OutletType) {
    //     json['data'].forEach((v) => data?.add(OutletType.fromJson(v) as T));
    //   } else if (T == LocationStock) {
    //     json['data'].forEach((v) => data?.add(LocationStock.fromJson(v) as T));
    //   } else if (T == Tag) {
    //     json['data'].forEach((v) => data?.add(Tag.fromJson(v) as T));
    //   } else if (T == AccountMove) {
    //     json['data'].forEach((v) => data?.add(AccountMove.fromJson(v) as T));
    //   } else if (T == ProductPriceListItem) {
    //     json['data']
    //         .forEach((v) => data?.add(ProductPriceListItem.fromJson(v) as T));
    //   } else if (T == StockQuant) {
    //     json['data'].forEach((v) => data?.add(StockQuant.fromJson(v) as T));
    //   } else if (T == StockPickingModel) {
    //     json['data']
    //         .forEach((v) => data?.add(StockPickingModel.fromJson(v) as T));
    //   } else if (T == SaleOrderType) {
    //     json['data'].forEach((v) => data?.add(SaleOrderType.fromJson(v) as T));
    //   } else if (T == StockPickingBatch) {
    //     json['data']
    //         .forEach((v) => data?.add(StockPickingBatch.fromJson(v) as T));
    //   } else if (T == StockOrder) {
    //     json['data'].forEach((v) => data?.add(StockOrder.fromJson(v) as T));
    //   } else if (T == CashCollect) {
    //     json['data'].forEach((v) => data?.add(CashCollect.fromJson(v) as T));
    //   } else if (T == StockPickingType) {
    //     json['data']
    //         .forEach((v) => data?.add(StockPickingType.fromJson(v) as T));
    //   } else if (T == UomLine) {
    //     json['data'].forEach((v) => data?.add(UomLine.fromJson(v) as T));
    //   } else if (T == Warehouse) {
    //     json['data'].forEach((v) => data?.add(Warehouse.fromJson(v) as T));
    //   } else if (T == PaymentTerm) {
    //     json['data'].forEach((v) => data?.add(PaymentTerm.fromJson(v) as T));
    //   } else if (T == MSCMUomLine) {
    //     json['data'].forEach((v) => data?.add(MSCMUomLine.fromJson(v) as T));
    //   } else if (T == Currency) {
    //     json['data'].forEach((v) => data?.add(Currency.fromJson(v) as T));
    //   } else if (T == PurchaseOrder) {
    //     json['data'].forEach((v) => data?.add(PurchaseOrder.fromJson(v) as T));
    //   } else if (T == RoutePlan) {
    //     json['data'].forEach((v) => data?.add(RoutePlan.fromJson(v) as T));
    //   } else if (T == CoinBill) {
    //     json['data'].forEach((v) => data?.add(CoinBill.fromJson(v) as T));
    //   } else if (T == MscmPaymentTransfer) {
    //     json['data']
    //         .forEach((v) => data?.add(MscmPaymentTransfer.fromJson(v) as T));
    //   } else if (T == AccountPayment) {
    //     json['data'].forEach((v) => data?.add(AccountPayment.fromJson(v) as T));
    //   } else if (T == AccountJournal) {
    //     json['data'].forEach((v) => data?.add(AccountJournal.fromJson(v) as T));
    //   } else
    //     throw Exception('model type not found in api response');
    // }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // if (data != null) {
    //   map['data'] = data?.map((v) => v.toJson()).toList();
    // }
    map['error'] = error;
    return map;
  }
}
