import '../src/enum.dart';

class UomUom {
  int? id;
  String? name;
  UomType? uomType;
  double? ratio;
  bool? active;
  double? rounding;
  int? uomCategoryId;
  String? uomCategoryName;
  String? writeDate;

  UomUom(
      {this.id,
      this.name,
      this.uomType,
      this.ratio,
      this.active,
        this.rounding,
      this.uomCategoryId,
      this.uomCategoryName,
      this.writeDate});

  UomUom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['uom_type'] != null) {
      UomType.values.forEach(
        (element) {
          if (element.name == json['uom_type']) {
            uomType = element;
          }
        },
      );
    }
    // uomType = json['uom_type'];
    rounding = json['rounding'];
    ratio = json['ratio'];
    active = json['active'];
    uomCategoryId = json['uom_category_id'];
    uomCategoryName = json['uom_category_name'];
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['uom_type'] = this.uomType?.name;
    data['ratio'] = this.ratio;
    data['active'] = this.active;
    data['rounding'] = rounding;
    data['uom_category_id'] = this.uomCategoryId;
    data['uom_category_name'] = this.uomCategoryName;
    data['write_date'] = this.writeDate;
    return data;
  }

  UomUom.fromJsonDB(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['uom_type'] != null) {
      UomType.values.forEach(
        (element) {
          if (element.name == json['uom_type']) {
            uomType = element;
          }
        },
      );
    }
    // uomType = json['uom_type'];
    rounding = json['rounding'];
    ratio = json['ratio'];
    active = (json['active'] == 1 ) ? true : false;
    uomCategoryId = json['uom_category_id'];
    uomCategoryName = json['uom_category_name'];
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJsonDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['uom_type'] = this.uomType?.name;
    data['ratio'] = this.ratio;
    data['rounding'] = this.rounding;
    data['active'] = (active == true) ? 1 : 0;
    data['uom_category_id'] = this.uomCategoryId;
    data['uom_category_name'] = this.uomCategoryName;
    data['write_date'] = this.writeDate;
    return data;
  }
}
