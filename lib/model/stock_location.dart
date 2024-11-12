import '../src/enum.dart';

class StockLocation {
  int? id;
  String? name;
  int? locationId;
  String? locationName;
  int? companyId;
  String? companyName;
  int? removalStrategyId;
  String? removalStrategyName;
  LocationTypes? usage;
  bool? scrapLocation;
  bool? returnLocation;
  bool? replenishLocation;
  String? writeDate;

  StockLocation(
      {this.id,
      this.name,
      this.locationId,
      this.locationName,
      this.companyId,
      this.companyName,
      this.removalStrategyId,
      this.removalStrategyName,
      this.usage,
      this.scrapLocation,
      this.returnLocation,
      this.replenishLocation,
      this.writeDate});

  StockLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationId = json['location_id'];
    locationName = json['location_name'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    removalStrategyId = json['removal_strategy_id'];
    removalStrategyName = json['removal_strategy_name'];
    if (json['usage'] != null) {
      LocationTypes.values.forEach(
        (element) {
          usage = element;
        },
      );
    }
    scrapLocation = json['scrap_location'];
    returnLocation = json['return_location'];
    replenishLocation = json['replenish_location'];
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['location_id'] = locationId;
    data['location_name'] = locationName;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['removal_strategy_id'] = removalStrategyId;
    data['removal_strategy_name'] = removalStrategyName;
    data['usage'] = usage?.name;
    data['scrap_location'] = scrapLocation;
    data['return_location'] = returnLocation;
    data['replenish_location'] = replenishLocation;
    data['write_date'] = writeDate;
    return data;
  }

  StockLocation.fromJsonDB(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationId = json['location_id'];
    locationName = json['location_name'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    removalStrategyId = json['removal_strategy_id'];
    removalStrategyName = json['removal_strategy_name'];
    if (json['usage'] != null) {
      LocationTypes.values.forEach(
        (element) {
          usage = element;
        },
      );
    }
    scrapLocation = json['scrap_location'] == 1;
    returnLocation = json['return_location'] == 1;
    replenishLocation = json['replenish_location'] == 1;
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJsonDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location_id'] = this.locationId;
    data['location_name'] = this.locationName;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['removal_strategy_id'] = this.removalStrategyId;
    data['removal_strategy_name'] = this.removalStrategyName;
    data['usage'] = usage?.name;
    data['scrap_location'] = this.scrapLocation == true ? 1 : 0;
    data['return_location'] = this.returnLocation == true ? 1 : 0;
    data['replenish_location'] = this.replenishLocation == true ? 1 : 0;
    data['write_date'] = this.writeDate;
    return data;
  }
}
