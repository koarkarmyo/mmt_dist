import 'package:image_picker/image_picker.dart';

class ResPartner {
  int? id;
  String? name;
  String? street;
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
  String? writeDate;
  String? partnerSaleType;
  XFile? image;

  ResPartner(
      { this.id,
        this.name,
        this.street,
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
        this.partnerSaleType,
        this.writeDate,
      this.image
      });

  ResPartner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    street = json['street'];
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
    writeDate = json['write_date'];
    partnerSaleType = json['partner_sale_type'];
  }

  ResPartner.fromJsonDB(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    street = json['street'];
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
    writeDate = json['write_date'];
    partnerSaleType = json['partner_sale_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['street'] = this.street;
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['city'] = this.city;
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['write_date'] = this.writeDate;
    data['partner_sale_type'] = partnerSaleType;
    return data;
  }
}
