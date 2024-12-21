enum CustVisitTypes {
  clock_in,
  clock_out,
  deli,
  order,
  collection,
  task,
  survey,
  gps,
}

class CustVisit {
  late String? docNo;
  late String docDate;
  late String? customerName;
  late CustVisitTypes docType;
  late int? customerId;
  late int employeeId;
  late int? vehicleId;
  late int deviceId;
  late String? photo;
  late double latitude;
  late double longitude;
  late String? remarks;
  late int isUpload;
  late bool fromDelivery;
  bool? fromWh;
  int? isTeleSale;

  CustVisit(
      {this.docNo,
      required this.docDate,
      required this.docType,
      required this.employeeId,
      this.customerId,
      required this.vehicleId,
      required this.deviceId,
      this.photo,
      this.customerName,
      this.fromDelivery = false,
      required this.latitude,
      required this.longitude,
      this.remarks,
      this.isTeleSale,
      this.fromWh,
      required this.isUpload});

  Map<String, dynamic> toJson() {
    return {
      'doc_no': this.docNo,
      'doc_date': this.docDate,
      'doc_type': this.docType.name,
      'employee_id': this.employeeId,
      'customer_id': this.customerId,
      'vehicle_id': this.vehicleId,
      'device_id': this.deviceId,
      'photo': this.photo ?? '',
      'latitude': this.latitude,
      'longitude': this.longitude,
      'from_delivery': this.fromDelivery,
      'from_wh_sale': this.fromWh,
      'remarks': this.remarks,
      'is_upload': this.isUpload,
      'sale_order_type_id': this.isTeleSale,
      'customer_name': this.customerName ?? '',
    };
  }

  Map<String, dynamic> toJsonDB() {
    return {
      'doc_no': this.docNo,
      'doc_date': this.docDate,
      'doc_type': this.docType.name,
      'employee_id': this.employeeId,
      'customer_id': this.customerId,
      'vehicle_id': this.vehicleId,
      'device_id': this.deviceId,
      'photo': this.photo ?? '',
      'latitude': this.latitude,
      'longitude': this.longitude,
      'from_delivery': this.fromDelivery == true ? 1 : 0,
      'from_wh_sale': this.fromWh == true ? 1 : 0,
      'remarks': this.remarks,
      'is_upload': this.isUpload == true ? 1 : 0,
      'sale_order_type_id': this.isTeleSale,
      'customer_name': this.customerName ?? '',
    };
  }

  CustVisit copyWith({
    String? docNo,
    String? docDate,
    CustVisitTypes? docType,
    int? customerId,
    int? employeeId,
    int? vehicleId,
    int? deviceId,
    String? photo,
    double? latitude,
    double? longitude,
    int? isUpload,
    bool? fromDelivery,
    String? remarks,
    String? customerName,
    int? saleOrderTypeId,
  }) {
    return CustVisit(
      docNo: docNo ?? this.docNo,
      photo: photo ?? this.photo,
      remarks: remarks ?? this.remarks,
      docDate: docDate ?? this.docDate,
      docType: docType ?? this.docType,
      employeeId: employeeId ?? this.employeeId,
      customerId: customerId ?? this.customerId,
      vehicleId: vehicleId ?? this.vehicleId,
      deviceId: deviceId ?? this.deviceId,
      latitude: latitude ?? this.latitude,
      isUpload: isUpload ?? this.isUpload,
      fromDelivery: fromDelivery ?? this.fromDelivery,
      longitude: longitude ?? this.longitude,
      customerName: customerName ?? this.customerName,
      isTeleSale: saleOrderTypeId ?? this.isTeleSale,
    );
  }

  CustVisit.fromJson(Map<String, dynamic> json) {
    this.docNo = json['doc_no'];
    this.docDate = json['doc_date'];
    this.customerId = json['customer_id'] ?? 0;
    this.docType = CustVisitTypes.values.byName(json['doc_type']);
    this.employeeId = json['employee_id'];
    this.vehicleId = json['vehicle_id'];
    this.deviceId = json['device_id'];
    this.photo = json['photo'];
    this.latitude = json['latitude'];
    this.longitude = json['longitude'];
    this.fromDelivery = json['from_delivery'] == 0 ? false : true;
    this.isUpload = json['is_upload'];
    this.remarks = json['remarks'];
    this.customerName = json['customer_name'];
    this.isTeleSale = json['sale_order_type_id'];
  }
}
