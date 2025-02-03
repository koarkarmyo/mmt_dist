/// id : 7
/// name : "AGL Pharma"
/// street2 : "two"
/// street : "one"
/// zone_id : 1
/// zone_name : "zone one"
/// township_id : 1
/// township_name : "township one"
/// ward_id : 1
/// ward_name : "ward one"
/// city_id : 1
/// city_name : "city one"
/// territory_id : 1
/// territory_name : "territory one"
/// state_id : 1766
/// state_name : "Mandalay"
/// city : ""
/// country_id : 145
/// country_name : "Myanmar"
/// company_id : 1
/// company_name : ""
/// zip : ""
/// phone : ""
/// mobile : ""
/// product_pricelist_id : 3
/// product_pricelist_name : "Default"
/// write_date : "1738310665.325497"

class ResPartner {
  ResPartner({
    this.id,
    this.name,
    this.street2,
    this.street,
    this.zoneId,
    this.zoneName,
    this.townshipId,
    this.townshipName,
    this.wardId,
    this.wardName,
    this.cityId,
    this.cityName,
    this.territoryId,
    this.territoryName,
    this.stateId,
    this.stateName,
    this.city,
    this.countryId,
    this.countryName,
    this.companyId,
    this.companyName,
    this.zip,
    this.phone,
    this.mobile,
    this.productPricelistId,
    this.productPricelistName,
    this.writeDate,
  });

  ResPartner.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    street2 = json['street2'];
    street = json['street'];
    zoneId = json['zone_id'];
    zoneName = json['zone_name'];
    townshipId = json['township_id'];
    townshipName = json['township_name'];
    wardId = json['ward_id'];
    wardName = json['ward_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    territoryId = json['territory_id'];
    territoryName = json['territory_name'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    city = json['city'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    zip = json['zip'];
    phone = json['phone'];
    mobile = json['mobile'];
    productPricelistId = json['product_pricelist_id'];
    productPricelistName = json['product_pricelist_name'];
    writeDate = json['write_date'];
  }

  int? id;
  String? name;
  String? street2;
  String? street;
  int? zoneId;
  String? zoneName;
  int? townshipId;
  String? townshipName;
  int? wardId;
  String? wardName;
  int? cityId;
  String? cityName;
  int? territoryId;
  String? territoryName;
  int? stateId;
  String? stateName;
  String? city;
  int? countryId;
  String? countryName;
  int? companyId;
  String? companyName;
  String? zip;
  String? phone;
  String? mobile;
  int? productPricelistId;
  String? productPricelistName;
  String? writeDate;

  ResPartner copyWith({
    int? id,
    String? name,
    String? street2,
    String? street,
    int? zoneId,
    String? zoneName,
    int? townshipId,
    String? townshipName,
    int? wardId,
    String? wardName,
    int? cityId,
    String? cityName,
    int? territoryId,
    String? territoryName,
    int? stateId,
    String? stateName,
    String? city,
    int? countryId,
    String? countryName,
    int? companyId,
    String? companyName,
    String? zip,
    String? phone,
    String? mobile,
    int? productPricelistId,
    String? productPricelistName,
    String? writeDate,
  }) =>
      ResPartner(
        id: id ?? this.id,
        name: name ?? this.name,
        street2: street2 ?? this.street2,
        street: street ?? this.street,
        zoneId: zoneId ?? this.zoneId,
        zoneName: zoneName ?? this.zoneName,
        townshipId: townshipId ?? this.townshipId,
        townshipName: townshipName ?? this.townshipName,
        wardId: wardId ?? this.wardId,
        wardName: wardName ?? this.wardName,
        cityId: cityId ?? this.cityId,
        cityName: cityName ?? this.cityName,
        territoryId: territoryId ?? this.territoryId,
        territoryName: territoryName ?? this.territoryName,
        stateId: stateId ?? this.stateId,
        stateName: stateName ?? this.stateName,
        city: city ?? this.city,
        countryId: countryId ?? this.countryId,
        countryName: countryName ?? this.countryName,
        companyId: companyId ?? this.companyId,
        companyName: companyName ?? this.companyName,
        zip: zip ?? this.zip,
        phone: phone ?? this.phone,
        mobile: mobile ?? this.mobile,
        productPricelistId: productPricelistId ?? this.productPricelistId,
        productPricelistName: productPricelistName ?? this.productPricelistName,
        writeDate: writeDate ?? this.writeDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['street2'] = street2;
    map['street'] = street;
    map['zone_id'] = zoneId;
    map['zone_name'] = zoneName;
    map['township_id'] = townshipId;
    map['township_name'] = townshipName;
    map['ward_id'] = wardId;
    map['ward_name'] = wardName;
    map['city_id'] = cityId;
    map['city_name'] = cityName;
    map['territory_id'] = territoryId;
    map['territory_name'] = territoryName;
    map['state_id'] = stateId;
    map['state_name'] = stateName;
    map['city'] = city;
    map['country_id'] = countryId;
    map['country_name'] = countryName;
    map['company_id'] = companyId;
    map['company_name'] = companyName;
    map['zip'] = zip;
    map['phone'] = phone;
    map['mobile'] = mobile;
    map['product_pricelist_id'] = productPricelistId;
    map['product_pricelist_name'] = productPricelistName;
    map['write_date'] = writeDate;
    return map;
  }
}

// import 'package:image_picker/image_picker.dart';
//
// class ResPartner {
//   int? id;
//   String? name;
//   String? street;
//   int? stateId;
//   String? stateName;
//   String? city;
//   int? countryId;
//   String? countryName;
//   int? companyId;
//   String? companyName;
//   String? zip;
//   String? phone;
//   String? mobile;
//   String? writeDate;
//   String? partnerSaleType;
//   XFile? image;
//
//   ResPartner(
//       { this.id,
//         this.name,
//         this.street,
//         this.stateId,
//         this.stateName,
//         this.city,
//         this.countryId,
//         this.countryName,
//         this.companyId,
//         this.companyName,
//         this.zip,
//         this.phone,
//         this.mobile,
//         this.partnerSaleType,
//         this.writeDate,
//       this.image
//       });
//
//   ResPartner.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     street = json['street'];
//     stateId = json['state_id'];
//     stateName = json['state_name'];
//     city = json['city'];
//     countryId = json['country_id'];
//     countryName = json['country_name'];
//     companyId = json['company_id'];
//     companyName = json['company_name'];
//     zip = json['zip'];
//     phone = json['phone'];
//     mobile = json['mobile'];
//     writeDate = json['write_date'];
//     partnerSaleType = json['partner_sale_type'];
//   }
//
//   ResPartner.fromJsonDB(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     street = json['street'];
//     stateId = json['state_id'];
//     stateName = json['state_name'];
//     city = json['city'];
//     countryId = json['country_id'];
//     countryName = json['country_name'];
//     companyId = json['company_id'];
//     companyName = json['company_name'];
//     zip = json['zip'];
//     phone = json['phone'];
//     mobile = json['mobile'];
//     writeDate = json['write_date'];
//     partnerSaleType = json['partner_sale_type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['street'] = this.street;
//     data['state_id'] = this.stateId;
//     data['state_name'] = this.stateName;
//     data['city'] = this.city;
//     data['country_id'] = this.countryId;
//     data['country_name'] = this.countryName;
//     data['company_id'] = this.companyId;
//     data['company_name'] = this.companyName;
//     data['zip'] = this.zip;
//     data['phone'] = this.phone;
//     data['mobile'] = this.mobile;
//     data['write_date'] = this.writeDate;
//     data['partner_sale_type'] = partnerSaleType;
//     return data;
//   }
// }
