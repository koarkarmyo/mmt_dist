class ProductGroup{
  int? id;
  String? name;

  ProductGroup({
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory ProductGroup.fromJson(Map<String, dynamic> map) {
    return ProductGroup(
      id: map['id'],
      name: map['name'],
    );
  }

  ProductGroup copyWith({
    int? id,
    String? name,
  }) {
    return ProductGroup(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}