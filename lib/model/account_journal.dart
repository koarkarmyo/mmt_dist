import 'dart:convert';

/// name : ""
/// type : ""
/// default_account_current_balance : 39494.0
/// company_id : 1
/// company_name : ""
/// write_date : "fjjfk"
/// id : 103

AccountJournal accountJournalFromJson(String str) =>
    AccountJournal.fromJson(json.decode(str));

String accountJournalToJson(AccountJournal data) => json.encode(data.toJson());

class AccountJournal {
  AccountJournal({
    this.name,
    this.type,
    this.defaultAccountCurrentBalance,
    this.companyId,
    this.companyName,
    this.writeDate,
    this.id,
  });

  AccountJournal.fromJson(dynamic json) {
    name = json['name'];
    type = json['type'];
    defaultAccountCurrentBalance = json['default_account_current_balance'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    writeDate = json['write_date'];
    id = json['id'];
  }

  String? name;
  String? type;
  double? defaultAccountCurrentBalance;
  int? companyId;
  String? companyName;
  String? writeDate;
  int? id;

  AccountJournal copyWith({
    String? name,
    String? type,
    double? defaultAccountCurrentBalance,
    int? companyId,
    String? companyName,
    String? writeDate,
    int? id,
  }) =>
      AccountJournal(
        name: name ?? this.name,
        type: type ?? this.type,
        defaultAccountCurrentBalance:
            defaultAccountCurrentBalance ?? this.defaultAccountCurrentBalance,
        companyId: companyId ?? this.companyId,
        companyName: companyName ?? this.companyName,
        writeDate: writeDate ?? this.writeDate,
        id: id ?? this.id,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['type'] = type;
    map['default_account_current_balance'] = defaultAccountCurrentBalance;
    map['company_id'] = companyId;
    map['company_name'] = companyName;
    map['write_date'] = writeDate;
    map['id'] = id;
    return map;
  }
}
