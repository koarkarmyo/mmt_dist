/// id : 1
/// name : "."
/// logo : ""
/// street : "No(11), Corner of 4 & 13th Street"
/// street2 : ""
/// phone : "09426007080"
/// mobile : ""
/// email : ""
/// website : ""

class CompanyId {
  CompanyId({
    int? id,
    String? name,
    String? logo,
    String? street,
    String? street2,
    String? phone,
    String? mobile,
    String? email,
    String? website,
    this.useLooseUom,
  }) {
    _id = id;
    _name = name;
    _logo = logo;
    _street = street;
    _street2 = street2;
    _phone = phone;
    _mobile = mobile;
    _email = email;
    _website = website;
  }

  CompanyId.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _logo = json['logo'];
    _street = json['street'];
    _street2 = json['street2'];
    _phone = json['phone'];
    _mobile = json['mobile'];
    _email = json['email'];
    _website = json['website'];
    useLooseUom = json['use_loose_uom'];
  }

  CompanyId.fromJsonDB(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _logo = json['logo'];
    _street = json['street'];
    _street2 = json['street2'];
    _phone = json['phone'];
    _mobile = json['mobile'];
    _email = json['email'];
    _website = json['website'];
    useLooseUom = json['use_loose_uom'] == 1;
  }

  int? _id;
  String? _name;
  String? _logo;
  String? _street;
  String? _street2;
  String? _phone;
  String? _mobile;
  String? _email;
  String? _website;
  bool? useLooseUom;

  CompanyId copyWith({
    int? id,
    String? name,
    String? logo,
    String? street,
    String? street2,
    String? phone,
    String? mobile,
    String? email,
    String? website,
    bool? useLooseUom,
  }) =>
      CompanyId(
        id: id ?? _id,
        name: name ?? _name,
        logo: logo ?? _logo,
        street: street ?? _street,
        street2: street2 ?? _street2,
        phone: phone ?? _phone,
        mobile: mobile ?? _mobile,
        email: email ?? _email,
        website: website ?? _website,
        useLooseUom: useLooseUom ?? this.useLooseUom,
      );

  int? get id => _id;

  String? get name => _name;

  String? get logo => _logo;

  String? get street => _street;

  String? get street2 => _street2;

  String? get phone => _phone;

  String? get mobile => _mobile;

  String? get email => _email;

  String? get website => _website;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['logo'] = _logo;
    map['street'] = _street;
    map['street2'] = _street2;
    map['phone'] = _phone;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['website'] = _website;
    map['use_loose_uom'] = useLooseUom;
    return map;
  }
}