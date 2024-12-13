/// id : 13
/// qty_available : 3000.0

class QtyCheckResponse {
  QtyCheckResponse({
    this.id,
    this.qtyAvailable,
  });

  QtyCheckResponse.fromJson(dynamic json) {
    id = json['id'];
    qtyAvailable = json['qty_available'] ?? 0.0;
  }

  int? id;
  double? qtyAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['qty_available'] = qtyAvailable;
    return map;
  }
}
