/// name : "MMK"
/// full_name : "Myanmar kyat"
/// rate : 1.0
/// symbol : "K"
/// decimal_places : 2
/// write_date : "2022-07-31 17:50:21.000000"

class Currency {
  int? id;
  String? name;
  String? fullName;
  double? rate;
  String? symbol;
  int? decimalPlaces;
  String? writeDate;

  Currency({
    this.id,
    this.name,
    this.fullName,
    this.rate,
    this.symbol,
    this.decimalPlaces,
    this.writeDate,
  });

  Currency.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    fullName = json['full_name'];
    rate = json['rate'];
    symbol = json['symbol'];
    decimalPlaces = json['decimal_places'];
    writeDate = json['write_date'];
  }

  Currency copyWith({
    int? id,
    String? name,
    String? fullName,
    double? rate,
    String? symbol,
    int? decimalPlaces,
    String? writeDate,
  }) =>
      Currency(
        id: id ?? this.id,
        name: name ?? this.name,
        fullName: fullName ?? this.fullName,
        rate: rate ?? this.rate,
        symbol: symbol ?? this.symbol,
        decimalPlaces: decimalPlaces ?? this.decimalPlaces,
        writeDate: writeDate ?? this.writeDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['full_name'] = fullName;
    map['rate'] = rate;
    map['symbol'] = symbol;
    map['decimal_places'] = decimalPlaces;
    map['write_date'] = writeDate;
    return map;
  }

  @override
  String toString() {
    return 'Currency{id: $id, name: $name, fullName: $fullName, rate: $rate, symbol: $symbol, decimalPlaces: $decimalPlaces, writeDate: $writeDate}';
  }


}
