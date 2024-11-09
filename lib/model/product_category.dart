class UomCategory {
  int? id;
  String? name;
  String? writeDate;

  UomCategory({
    this.id,
    this.name,
    this.writeDate,
  });

  // Convert JSON to UomCategory instance
  factory UomCategory.fromJson(Map<String, dynamic> json) {
    return UomCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      writeDate: json['write_date'] as String?,
    );
  }

  // Convert UomCategory instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'write_date': writeDate,
    };
  }
}
