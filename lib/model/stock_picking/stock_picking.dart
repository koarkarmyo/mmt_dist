import 'package:collection/collection.dart';
import '../../src/enum.dart';
import 'stock_move_line.dart';

class StockPicking {
  int? id;
  String? name;
  int? locationId;
  int? locationDestId;
  int? employeeId;
  int? partnerId;
  String? partnerName;
  String? note;
  String? origin;
  int? saleId;
  PickingStatus? state;
  bool? isChecked;
  int? packageNo;
  int? batchId;
  String? batchName;
  String? dateDone;
  List<StockMoveLine>? moveLines;

  StockPicking({
    this.id,
    this.name,
    this.locationId,
    this.locationDestId,
    this.employeeId,
    this.partnerName,
    this.partnerId,
    this.note,
    this.origin,
    this.saleId,
    this.state,
    this.packageNo,
    this.batchName,
    this.batchId,
    this.isChecked,
    this.moveLines,
    this.dateDone,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location_id': locationId,
      'location_dest_id': locationDestId,
      'employee_id': employeeId,
      'partner_id': partnerId,
      'partner_name': partnerName,
      'note': note,
      'origin': origin,
      'sale_id': saleId,
      'package_no': packageNo,
      'batch_id': batchId,
      'batch_name': batchName,
      'state': state?.name,
      'date_done': dateDone,
    };
  }

  factory StockPicking.fromJson(Map<String, dynamic> map) {
    return StockPicking(
      id: map['id'],
      name: map['name'],
      locationId: map['location_id'],
      locationDestId: map['location_dest_id'],
      employeeId: map['employee_id'],
      partnerId: map['partner_id'],
      partnerName: map['partner_name'],
      note: map['note'],
      origin: map['origin'],
      saleId: map['sale_id'],
      batchId: map['batch_id'],
      batchName: map['batch_name'],
      packageNo: map['package_no'],
      dateDone: map['date_done'],
      state: PickingStatus.values
          .firstWhereOrNull((element) => element.name == map['state']),
    );
  }

  StockPicking copyWith({
    int? id,
    String? name,
    int? locationId,
    int? locationDestId,
    int? employeeId,
    int? partnerId,
    String? partnerName,
    String? note,
    String? origin,
    int? saleId,
    int? packageNo,
    int? batchId,
    String? batchName,
    PickingStatus? state,
    bool? isChecked,
    List<StockMoveLine>? moveLines,
    String? dateDone,
  }) {
    return StockPicking(
      id: id ?? this.id,
      name: name ?? this.name,
      locationId: locationId ?? this.locationId,
      locationDestId: locationDestId ?? this.locationDestId,
      employeeId: employeeId ?? this.employeeId,
      partnerId: partnerId ?? this.partnerId,
      partnerName: partnerName ?? this.partnerName,
      note: note ?? this.note,
      origin: origin ?? this.origin,
      saleId: saleId ?? this.saleId,
      state: state ?? this.state,
      packageNo: packageNo ?? this.packageNo,
      batchId: batchId ?? this.batchId,
      batchName: batchName ?? this.batchName,
      isChecked: isChecked ?? this.isChecked,
      moveLines: moveLines ?? this.moveLines,
      dateDone: dateDone ?? this.dateDone,
    );
  }
}
