class EmployeeLocation{
  int? id;
  String? name;
  bool? isVehicle;
  String? completeName;

  EmployeeLocation({
    this.id,
    this.name,
    this.isVehicle,
    this.completeName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'is_vehicle': this.isVehicle,
      'complete_name': this.completeName,
    };
  }

  factory EmployeeLocation.fromJson(Map<String, dynamic> map) {
    return EmployeeLocation(
      id: map['id'],
      name: map['name'],
      isVehicle: map['is_vehicle'],
      completeName: map['complete_name'],
    );
  }

  factory EmployeeLocation.fromJsonDB(Map<String, dynamic> map) {
    return EmployeeLocation(
      id: map['id'],
      name: map['name'],
      isVehicle: map['is_vehicle'] == null ? null : map['is_vehicle'] == 1,
      completeName: map['complete_name'],
    );
  }

  EmployeeLocation copyWith({
    int? id,
    String? name,
    bool? isVehicle,
    String? completeName,
  }) {
    return EmployeeLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      isVehicle: isVehicle ?? this.isVehicle,
      completeName: completeName ?? this.completeName,
    );
  }
}