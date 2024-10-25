class SyncActionGroup {
  int? id;
  String? name;

  SyncActionGroup({
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory SyncActionGroup.fromJson(Map<String, dynamic> map) {
    return SyncActionGroup(
      id: map['id'],
      name: map['name'],
    );
  }

  SyncActionGroup copyWith({
    int? id,
    String? name,
  }) {
    return SyncActionGroup(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
