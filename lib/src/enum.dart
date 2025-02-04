import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:mmt_mobile/src/style/app_color.dart';
import '../utils/date_time_utils.dart';
import 'mmt_application.dart';

enum LocationTypes {
  supplier,
  view,
  internal,
  customer,
  inventory,
  production,
  transit
}

enum LooseBoxType { pk, pc }

enum TrackingType { serial, lot, none }

enum SaleItemType { sale, foc, coupon }

enum UomType { reference, bigger, smaller }

enum LanguageCode { eng, mm }

enum ViewTypes { list, grid }

enum OrderStates { draft, send, sale, done, cancel }

enum SaleOrderReqTypes { quotation, sale, sale_delivery_and_invoice, wh_sale }

enum StockMoveType { deli, load, unload, variant }

enum NoSeriesDocType { loading, unloading, order, delivery, stock_order }

// enum ProductDetailTypes { product, consu, service }

enum ProductTypes { consu, service, combo }

// enum PurchaseOrderStates { draft, sent, toApprove, purchase, done, cancel }

enum DeliveryStatus { draft, waiting, confirmed, assigned, done, cancel, all }

enum PurchaseOrderStates { all, draft, sent, toApprove, purchase, done, cancel }

enum InvoiceStatus { no, invoiced, to_invoice }

extension InvoiceStatusExtension on InvoiceStatus {
  String get displayTitle {
    switch (this) {
      case InvoiceStatus.to_invoice:
        return 'to invoice';
      case InvoiceStatus.invoiced:
        return 'invoiced';
      case InvoiceStatus.no:
        return 'no';
      default:
        return 'There is no such status';
    }
  }
}

enum PickingStatus { draft, waiting, confirmed, assigned, done, cancel }

enum StockPickingSequenceCode {
  IN,
  INT,
  IN_REC,
  PICK,
  PICKUP,
  PACK,
  SFP,
  MO,
  PC,
  OUT
}

enum MoveTypes {
  entry,
  out_invoice,
  out_refund,
  in_invoice,
  in_refund,
  out_receipt,
  in_receipt
}

enum PaymentState {
  not_paid,
  in_payment,
  paid,
  partial,
  reversed,
  invoicing_legacy
}

extension PaymentStatusExtension on PaymentState {
  String title() {
    switch (this) {
      case PaymentState.not_paid:
        return 'Not Paid';
      case PaymentState.in_payment:
        return 'In Payment';
      case PaymentState.paid:
        return 'Paid';
      case PaymentState.partial:
        return 'Partially Paid';
      case PaymentState.reversed:
        return 'Reversed';
      case PaymentState.invoicing_legacy:
        return 'Invoicing App Legacy';
      default:
        return 'Payment Status does not exist';
    }
  }
}

enum AccountMoveActions { action_post, reset_to_draft, action_cancel }

extension AMActionsExtension on AccountMoveActions {
  String get displayTitle {
    switch (this) {
      case AccountMoveActions.action_post:
        return 'Confirm';
      case AccountMoveActions.action_cancel:
        return 'Cancel';
      case AccountMoveActions.reset_to_draft:
        return 'Reset to draft';
      default:
        return 'There is no such status';
    }
  }
}

enum AccountMoveStates { all, draft, posted, cancel }

enum AccountMovesFilterStates { State, Partner, Payment_State }

enum StockPickingCodes { incoming, outgoing, internal, mrp_operation }

enum PurchaseFilterStates { State, Vendor, Branch, PurchasePerson }

enum PurchaseActions {
  confirm,
  delete,
  cancel,
  set_to_draft,
  action_create_invoice
}

enum PurchaseOrderFilterStates {
  all,
  draft,
  sent,
  toApprove,
  purchase,
  done,
  cancel
}

extension FirstLetterCapital on String {
  String toFirstLetterCapital() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension PurchaseOrderStatesExt on PurchaseOrderStates {
  String get actualValue {
    switch (this) {
      case PurchaseOrderStates.all:
        return "All";
      case PurchaseOrderStates.draft:
        return "Draft";
      case PurchaseOrderStates.sent:
        return "Sent";
      case PurchaseOrderStates.toApprove:
        return "To Approve";
      case PurchaseOrderStates.purchase:
        return "Purchase Order";
      case PurchaseOrderStates.done:
        return "Locked";
      case PurchaseOrderStates.cancel:
        return "Cancelled";
    }
  }
}

enum DeliveryStates {
  processing,
  load,
  assigned,
  done,
  partial,
  cancel,
  order_cancel
}

extension DeliveryStatesToValue on DeliveryStates {
  String get getConstantValue {
    if (this == DeliveryStates.order_cancel) {
      return 'Order cancel';
    }
    return name.toFirstLetterCapital();
  }
}

enum ReturnStates { assigned, done }

enum DeliveryFilterTypes { all, done, processing, load, cancel, partial }

enum DeliveryReportTypes { all, done, partial, cancel, load }

enum PartnerState { New, Regular, Blocked }

enum InvoiceStates { draft, posted, cancel }

enum SaleOrderReportFilter { saleQty, saleAmount, unsoldProduct }

enum PaymentStates {
  not_paid,
  in_payment,
  paid,
  partial,
  reversed,
  invoicing_legacy
}

// enum CustomerFilterType { ALL, VISITED, MISSED }

extension DeliveryStatusToValue on DeliveryStatus {
  String getConstValue() {
    switch (this) {
      case DeliveryStatus.draft:
        return 'Draft';
      case DeliveryStatus.waiting:
        return 'Waiting approve';
      case DeliveryStatus.confirmed:
        return 'Waiting';
      case DeliveryStatus.assigned:
        return 'Ready';
      case DeliveryStatus.done:
        return 'Done';
      case DeliveryStatus.cancel:
        return 'Cancel';
      case DeliveryStatus.all:
        return 'All';
    }
  }
}

enum DiscountTypes { K, Percentage }

enum PaymentTypes { cash, bank }

extension PaymentTypesValue on PaymentTypes {
  String getConstValue() {
    return name.toFirstLetterCapital();
  }
}

extension DiscountTypesValue on DiscountTypes {
  String getConstValue() {
    switch (this) {
      case DiscountTypes.K:
        return 'K';
      case DiscountTypes.Percentage:
        return '%';
    }
  }
}

extension DeliveryFilterTypesValue on DeliveryFilterTypes {
  String getConstValue() {
    return name.toFirstLetterCapital();
  }
}

abstract class EnumUtils<T extends Enum> extends Iterable<T> {
  // String getConstValue() {
  //   return this.name.toFirstLetterCapital();
  // }

  T getEnum(String value) {
    return byName(value);
  }
}

/*
 Delivery Processing state
*/

enum ServiceProductType {
  discount,
  foc,
  gift,
  delivery,
  per_disc,
}

extension ServiceProductTypeValue on ServiceProductType {
  String getConstValue() {
    if (ServiceProductType.per_disc == this) {
      return 'Percent Disc';
    }
    return name.toFirstLetterCapital();
  }
}

enum DeliveryReserveStatus { done, keep, rtn, back }

// cos dart sdk version < 2.16
extension DeliveryOrderStateToValue on DeliveryReserveStatus {
  String getConstValue() {
    switch (this) {
      case DeliveryReserveStatus.done:
        return 'Done';
      case DeliveryReserveStatus.keep:
        return 'Keep';
      case DeliveryReserveStatus.rtn:
        return 'Return';
      case DeliveryReserveStatus.back:
        return 'Back Order';
    }
  }

  DeliveryReserveStatus getName(String value) {
    return DeliveryReserveStatus.values.byName(value);
  }
}

enum PaymentTransferStates { draft, posted, cancel }

// cos dart sdk version < 2.16
extension PaymentTransferStatesToValue on PaymentTransferStates {
  String get getConstValue {
    return name.toFirstLetterCapital();
  }

  Color get getColor {
    switch (this) {
      case PaymentTransferStates.draft:
        return AppColors.primaryColor;
      case PaymentTransferStates.cancel:
        return AppColors.dangerColor;
      case PaymentTransferStates.posted:
        return AppColors.successColor;
    }
  }
}

/*
 ############################
*/

extension Iterables<T> on Iterable<T> {
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) => fold(
      <K, List<T>>{},
      (Map<K, List<T>> map, T element) =>
          map..putIfAbsent(keyFunction(element), () => <T>[]).add(element));
}

extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var wom = 0;
    var date = this;

    while (date.month == month) {
      wom++;
      date = date.subtract(const Duration(days: 7));
    }

    return wom;
  }
}

extension DurationToString on Duration {
  int get inYears {
    if (inDays < 1) return 0;

    return inDays ~/ 365;
  }

  int get inMonth {
    if (inDays < 1) return 0;

    int month = inDays ~/ 31;

    if (inDays > 365) {
      month = (inDays.remainder(365) ~/ 31);
    }
    return month;
  }

  int get inCDays {
    int day = inDays;
    int month = 0;

    if (inDays > 365) {
      month = inDays.remainder(365) ~/ 31;
    }

    if (inDays >= 31) {
      day = inDays - ((month * 31) + (inYears * 365));
    }

    return day;
  }

  String get durationString {
    String string = '';
    if (inYears > 0) {
      string = '${inYears} year';
    }

    if (inMonth > 0) {
      if (string.isNotEmpty) string = '$string/ ';
      string = '$string$inMonth month';
    }

    if (string.isNotEmpty) string = '$string/ ';
    if (inDays == 1) {
      string = 'Yesterday';
    } else if (inDays == 0) {
      string = 'Today';
    } else if (inDays > 1) {
      string = '$string$inCDays Day ago';
    }
    // if (string.trim().isNotEmpty) {
    //   string = '$string ';
    // }

    // if (string.isEmpty) {
    //   string = 'Today';
    // }
    // if (string.trim().isNotEmpty) {
    //   string = '$string ';
    // }
    //
    // string =
    //     '$string${this.inHours.remainder(24) > 0 ? this.inHours.remainder(24) : '00'}:${this.inMinutes.remainder(60) > 0 ? this.inMinutes.remainder(60) : '00'}:${this.inSeconds.remainder(60) > 0 ? this.inSeconds.remainder(60) : '00'}';
    return string;
  }
}

enum CashCollectTypes {
  full,
  partial,
}

extension ChangeDoubleToString on double {
  String toQty([int? digit]) {
    // MMTApplication.qtyDigit
    return toStringAsFixed(digit ?? 0);
  }

  String toPrice([int? digit]) {
    return toStringAsFixed(digit ?? 0);
  }
}

extension StringDateTimeExtension on String? {
  String format({DateFormat? format}) {
    format ??= DateTimeUtils.ddMmYYYHMSsAFormat;
    if (this == null) {
      return '';
    }
    try {
      return format.format(DateTime.parse(this!));
    } catch (e) {
      return '';
    }
  }
}

//
enum JournalTypes { sale, purchase, cash, bank, general }

extension JournalTypesValue on JournalTypes {
  String get getConstValue {
    switch (this) {
      case JournalTypes.general:
        return 'Miscellaneous';
      default:
        return name.toFirstLetterCapital();
    }
  }

  Color get getColor {
    return this != JournalTypes.sale
        ? AppColors.infoColor
        : AppColors.dangerColor;
  }
}

//
enum AccountPaymentTypes { outbound, inbound, all }

extension AccountPaymentTypesValue on AccountPaymentTypes {
  String getConstValue() {
    switch (this) {
      case AccountPaymentTypes.inbound:
        return 'Received';
      case AccountPaymentTypes.outbound:
        return 'Sent';
      default:
        return name.toFirstLetterCapital();
    }
    return name.toFirstLetterCapital();
  }

  Color get getColor {
    return this != AccountPaymentTypes.outbound
        ? AppColors.infoColor
        : AppColors.dangerColor;
  }
}

//
enum AccountPaymentState { draft, posted, cancel }

extension AccountPaymentStateValue on AccountPaymentState {
  String getConstValue() {
    return name.toFirstLetterCapital();
  }

  Color getColorValue() {
    switch (this) {
      case AccountPaymentState.draft:
        return AppColors.infoColor;
      case AccountPaymentState.cancel:
        return AppColors.dangerColor;
      case AccountPaymentState.posted:
        return AppColors.successColor;
    }
  }
}
//
