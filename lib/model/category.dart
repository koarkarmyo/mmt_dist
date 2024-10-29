import 'dart:convert';

/// id : 2
/// name : "Saleable"
/// complete_name : "All / Saleable"
/// parent_id : 1
/// parent_path : "1/2/"
/// child_id : [4]
/// write_date : "2022-02-27 08:38:36"
/// parent_name : "All"

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  int? id;
  String? name;
  String? completeName;
  int? parentId;
  String? parentPath;
  List<int>? childId;
  String? writeDate;
  String? parentName;

  Category({
    this.id,
    this.name,
    this.completeName,
    this.parentId,
    this.parentPath,
    this.childId,
    this.writeDate,
    this.parentName,
  });

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    completeName = json['complete_name'];
    parentId = json['parent_id'];
    parentPath = json['parent_path'];
    childId = json['child_id'] != null ? json['child_id'].cast<int>() : [];
    writeDate = json['write_date'];
    parentName = json['parent_name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['complete_name'] = completeName;
    map['parent_id'] = parentId;
    map['parent_path'] = parentPath;
    map['child_id'] = childId;
    map['write_date'] = writeDate;
    map['parent_name'] = parentName;
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['complete_name'] = completeName;
    map['parent_id'] = parentId;
    map['parent_path'] = parentPath;
    // map['child_id'] = childId;
    map['write_date'] = writeDate;
    map['parent_name'] = parentName;
    return map;
  }
}
