import 'dart:convert';

import 'package:collection/collection.dart';

import '../src/enum.dart';

/// id : 30554
/// write_date : "2023-06-30 15:45:19.000001"
/// name : "D001/2023/06/0006"
/// date : "2023-06-30"
/// journal_id : 11
/// payment_method_line_id : 8
/// partner_id : 1
/// employee_id : null
/// amount_company_currency_signed : -3000.0
/// amount : 3000.0
/// state : "posted"
/// amount_signed : -3000.0
/// is_internal_transfer : true
/// payment_type : "outbound"
/// partner_type : "supplier"
/// ref : null
/// currency_id : 115
/// journal_name : "D001- VEN SALE"
/// payment_method_line_name : "Manual"
/// partner_name : "."
/// employee_name : null
/// currency_name : "MMK"

AccountPayment accountPaymentFromJson(String str) =>
    AccountPayment.fromJson(json.decode(str));

String accountPaymentToJson(AccountPayment data) => json.encode(data.toJson());

class AccountPayment {
  int? id;
  String? writeDate;
  String? name;
  String? date;
  int? journalId;
  int? paymentMethodLineId;
  int? partnerId;
  int? employeeId;
  double? amountCompanyCurrencySigned;
  double? amount;
  AccountPaymentState? state;
  double? amountSigned;
  bool? isInternalTransfer;
  AccountPaymentTypes? paymentType;
  String? partnerType;
  String? ref;
  int? currencyId;
  String? journalName;
  String? paymentMethodLineName;
  String? partnerName;
  String? employeeName;
  String? currencyName;

  // "document_type",
  // "origin_document_no",
  // "balance_date",
  // "j_balance",
  // "left_balance",
  // "company_id"
  String? documentType;
  String? originDocumentNo;
  String? balanceDate;
  double? jBalance;
  double? leftBalance;
  int? companyId;
  String? companyName;

  AccountPayment({
    this.id,
    this.writeDate,
    this.name,
    this.date,
    this.journalId,
    this.paymentMethodLineId,
    this.partnerId,
    this.employeeId,
    this.amountCompanyCurrencySigned,
    this.amount,
    this.state,
    this.amountSigned,
    this.isInternalTransfer,
    this.paymentType,
    this.partnerType,
    this.ref,
    this.currencyId,
    this.journalName,
    this.paymentMethodLineName,
    this.partnerName,
    this.employeeName,
    this.currencyName,
    this.documentType,
    this.originDocumentNo,
    this.balanceDate,
    this.jBalance,
    this.leftBalance,
    this.companyId,
    this.companyName,
  });

  AccountPayment.fromJson(dynamic json) {
    id = json['id'];
    writeDate = json['write_date'];
    name = json['name'];
    date = json['date'];
    journalId = json['journal_id'];
    paymentMethodLineId = json['payment_method_line_id'];
    partnerId = json['partner_id'];
    employeeId = json['employee_id'];
    amountCompanyCurrencySigned = json['amount_company_currency_signed'];
    amount = json['amount'];
    state = AccountPaymentState.values
        .firstWhereOrNull((element) => element.name == json['state']);
    // state = json['state'];
    amountSigned = json['amount_signed'];
    if (json['is_internal_transfer'].runtimeType == int)
      isInternalTransfer = json['is_internal_transfer'] == 1;
    else
      isInternalTransfer = json['is_internal_transfer'];
    paymentType = AccountPaymentTypes.values
        .firstWhereOrNull((element) => json['payment_type'] == element.name);
    partnerType = json['partner_type'];
    ref = json['ref'];
    currencyId = json['currency_id'];
    journalName = json['journal_name'];
    paymentMethodLineName = json['payment_method_line_name'];
    partnerName = json['partner_name'];
    employeeName = json['employee_name'];
    currencyName = json['currency_name'];
    //
    documentType = json['document_type'];
    originDocumentNo = json['origin_document_no'];
    balanceDate = json['balance_date'];
    currencyId = json['currency_id'];
    jBalance = json['j_balance'];
    leftBalance = json['left_balance'];
    companyId = json['company_id'];
    companyName = json['company_name'];
  }

  AccountPayment copyWith({
    int? id,
    String? writeDate,
    String? name,
    String? date,
    int? journalId,
    int? paymentMethodLineId,
    int? partnerId,
    int? employeeId,
    double? amountCompanyCurrencySigned,
    double? amount,
    AccountPaymentState? state,
    double? amountSigned,
    bool? isInternalTransfer,
    AccountPaymentTypes? paymentType,
    String? partnerType,
    String? ref,
    int? currencyId,
    String? journalName,
    String? paymentMethodLineName,
    String? partnerName,
    String? employeeName,
    String? currencyName,
  }) =>
      AccountPayment(
        id: id ?? this.id,
        writeDate: writeDate ?? this.writeDate,
        name: name ?? this.name,
        date: date ?? this.date,
        journalId: journalId ?? this.journalId,
        paymentMethodLineId: paymentMethodLineId ?? this.paymentMethodLineId,
        partnerId: partnerId ?? this.partnerId,
        employeeId: employeeId ?? this.employeeId,
        amountCompanyCurrencySigned:
            amountCompanyCurrencySigned ?? this.amountCompanyCurrencySigned,
        amount: amount ?? this.amount,
        state: state ?? this.state,
        amountSigned: amountSigned ?? this.amountSigned,
        isInternalTransfer: isInternalTransfer ?? this.isInternalTransfer,
        paymentType: paymentType ?? this.paymentType,
        partnerType: partnerType ?? this.partnerType,
        ref: ref ?? this.ref,
        currencyId: currencyId ?? this.currencyId,
        journalName: journalName ?? this.journalName,
        paymentMethodLineName:
            paymentMethodLineName ?? this.paymentMethodLineName,
        partnerName: partnerName ?? this.partnerName,
        employeeName: employeeName ?? this.employeeName,
        currencyName: currencyName ?? this.currencyName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['write_date'] = writeDate;
    map['name'] = name;
    map['date'] = date;
    map['journal_id'] = journalId;
    map['payment_method_line_id'] = paymentMethodLineId;
    map['partner_id'] = partnerId;
    map['employee_id'] = employeeId;
    map['amount_company_currency_signed'] = amountCompanyCurrencySigned;
    map['amount'] = amount;
    map['state'] = state?.name;
    map['amount_signed'] = amountSigned;
    map['is_internal_transfer'] = isInternalTransfer;
    map['payment_type'] = paymentType?.name;
    map['partner_type'] = partnerType;
    map['ref'] = ref;
    map['currency_id'] = currencyId;
    map['journal_name'] = journalName;
    map['payment_method_line_name'] = paymentMethodLineName;
    map['partner_name'] = partnerName;
    map['employee_name'] = employeeName;
    map['currency_name'] = currencyName;
    map['document_type'] = documentType;
    map['origin_document_no'] = originDocumentNo;
    map['balance_date'] = balanceDate;
    map['currency_id'] = currencyId;
    map['j_balance'] = jBalance;
    map['left_balance'] = leftBalance;
    map['company_id'] = companyId;
    map['company_name'] = companyName;
    return map;
  }
}
