//order_id
//order_name
//id
//date collect_amount employee_id partner_id signed_on

class CashCollect {
  int? id;
  int? employeeId;
  String? employeeName;
  String? orderNo;
  String? date;
  int? orderId;
  double? collectAmount;
  double? totalAmount;
  int? partnerId;
  String? signedOn;
  String? partnerName;
  String? writeDate;

  CashCollect({
    this.id,
    this.employeeId,
    this.orderNo,
    this.date,
    this.orderId,
    this.signedOn,
    this.collectAmount,
    this.partnerId,
    this.partnerName,
    this.employeeName,
    this.totalAmount,
    this.writeDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'employee_id': this.employeeId,
      'employee_name': this.employeeName,
      'date': this.date,
      'order_id': this.orderId,
      'order_name': this.orderNo,
      'signed_on': this.signedOn,
      'collect_amount': this.collectAmount,
      'partner_id': this.partnerId,
      'partner_name': this.partnerName,
      'write_date': this.writeDate,
    };
  }

  factory CashCollect.fromJson(Map<String, dynamic> map) {
    return CashCollect(
        id: map['id'],
        employeeId: map['employee_id'],
        orderNo: map['order_name'],
        date: map['date'],
        orderId: map['order_id'],
        employeeName: map['employee_name'],
        partnerName: map['partner_name'],
        collectAmount: map['collect_amount'],
        partnerId: map['partner_id'],
        writeDate: map['write_date'],
        signedOn: map['signed_on']);
  }

  CashCollect copyWith({
    int? id,
    int? employeeId,
    String? date,
    int? orderId,
    String? orderNo,
    double? collectAmount,
    double? totalAmount,
    int? partnerId,
    String? partnerName,
    String? employeeName,
    String? signedOn,
    String? writeDate,
  }) {
    return CashCollect(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      orderNo: orderNo ?? this.orderNo,
      date: date ?? this.date,
      orderId: orderId ?? this.orderId,
      collectAmount: collectAmount ?? this.collectAmount,
      partnerId: partnerId ?? this.partnerId,
      partnerName: partnerName ?? this.partnerName,
      employeeName: employeeName ?? this.employeeName,
      signedOn: signedOn ?? this.signedOn,
      totalAmount: totalAmount ?? this.totalAmount,
      writeDate: writeDate ?? this.writeDate,
    );
  }
}
