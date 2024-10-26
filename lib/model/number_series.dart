/// id : 1
/// name : "loading"
/// prefix : "1L"
/// use_year : true
/// use_month : true
/// use_day : true
/// reset_in : "d"
/// number_length : 10
/// number_last : 0
/// year_last : 0
/// month_last : 0
/// day_last : 0

class NumberSeries {
  NumberSeries({
    this.id,
    this.name,
    this.prefix,
    this.useYear,
    this.useMonth,
    this.useDay,
    this.resetIn,
    this.numberLength,
    this.numberLast,
    this.yearLast,
    this.monthLast,
    this.dayLast,
  });

  NumberSeries.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    prefix = json['prefix'];
    useYear = json['use_year'];
    useMonth = json['use_month'];
    useDay = json['use_day'];
    resetIn = json['reset_in'];
    numberLength = json['number_length'];
    numberLast = json['number_last'];
    yearLast = json['year_last'];
    monthLast = json['month_last'];
    dayLast = json['day_last'];
  }

  NumberSeries.fromJsonDB(dynamic json) {
    id = json['id'];
    name = json['name'];
    prefix = json['prefix'];
    useYear = json['use_year'] == 0 ? false : true;
    useMonth = json['use_month'] == 0 ? false : true;
    useDay = json['use_day'] == 0 ? false : true;
    resetIn = json['reset_in'];
    numberLength = json['number_length'];
    numberLast = json['number_last'];
    yearLast = json['year_last'];
    monthLast = json['month_last'];
    dayLast = json['day_last'];
  }

  late int? id;
  late String? name;
  late String? prefix;
  late bool? useYear;
  late bool? useMonth;
  late bool? useDay;
  late String? resetIn;
  late int? numberLength;
  late int? numberLast;
  late int? yearLast;
  late int? monthLast;
  late int? dayLast;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['prefix'] = prefix;
    map['use_year'] = useYear;
    map['use_month'] = useMonth;
    map['use_day'] = useDay;
    map['reset_in'] = resetIn;
    map['number_length'] = numberLength;
    map['number_last'] = numberLast;
    map['year_last'] = yearLast;
    map['month_last'] = monthLast;
    map['day_last'] = dayLast;
    return map;
  }
}
