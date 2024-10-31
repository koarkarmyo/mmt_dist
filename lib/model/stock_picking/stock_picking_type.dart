import 'package:collection/collection.dart';

import '../../src/enum.dart';

class StockPickingType {
  int? id;
  String? name;
  String? displayName;
  StockPickingCodes? code;
  StockPickingSequenceCode? sequenceCode;
  int? warehouseId;
  String? warehouseName;
  int? companyId;
  String? companyName;
  String? writeDate;

  StockPickingType(
      {this.id,
      this.name,
      this.displayName,
      this.code,
      this.warehouseId,
      this.warehouseName,
      this.companyId,
      this.sequenceCode,
      this.companyName,
      this.writeDate});

  StockPickingType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    code = StockPickingCodes.values
        .firstWhereOrNull((element) => element.name == json['code']);
    warehouseId = json['warehouse_id'];
    warehouseName = json['warehouse_name'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    sequenceCode = StockPickingSequenceCode.values
        .firstWhereOrNull((element) => element.name == json['sequence_code']);
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['display_name'] = displayName;
    data['code'] = code?.name;
    data['warehouse_id'] = warehouseId;
    data['warehouse_name'] = warehouseName;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['sequence_code'] = sequenceCode?.name;
    data['write_date'] = writeDate;
    return data;
  }

  StockPickingType copyWith({
    int? id,
    String? name,
    String? displayName,
    StockPickingCodes? code,
    int? warehouseId,
    String? warehouseName,
    int? companyId,
    String? companyName,
    String? writeDate,
    StockPickingSequenceCode? sequenceCode,
  }) {
    return StockPickingType(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      code: code ?? this.code,
      warehouseId: warehouseId ?? this.warehouseId,
      warehouseName: warehouseName ?? this.warehouseName,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      sequenceCode: sequenceCode ?? this.sequenceCode,
      writeDate: writeDate ?? this.writeDate,
    );
  }
}
