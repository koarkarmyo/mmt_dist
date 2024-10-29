class Tag {
  int? _id;
  String? _name;
  String? _writeDate;

  Tag({
    required int? id,
    required String? name,
    String? writeDate,
  })  : _id = id,
        _name = name,
        _writeDate = writeDate;

  Map<String, dynamic> toJson() {
    return {
      'id': this._id,
      'name': this._name,
      'write_date': this._writeDate,
    };
  }

  factory Tag.fromJson(Map<String, dynamic> map) {
    return Tag(
      id: map['id'],
      name: map['name'],
      writeDate: map['write_date'],
    );
  }

  int? get id => _id;

  set setId(int value) {
    _id = value;
  }

  String? get name => _name;

  set setName(String value) {
    _name = value;
  }

  String? get writeDate => _writeDate;

  set setWriteDate(String value) {
    _writeDate = value;
  }
}
