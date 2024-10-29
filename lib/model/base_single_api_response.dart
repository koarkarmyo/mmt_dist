/// data : [{"id":2,"name":"get_inventory_item","priority":2,"is_auto_sync":false,"is_manual_sync":true,"is_upload":false,"action_group":[1,"MASTER"],"solution_id":"sale"},{"id":1,"name":"get_route","priority":1,"is_auto_sync":true,"is_manual_sync":true,"is_upload":false,"action_group":[1,"MASTER"],"solution_id":"sale"}]
/// error : ""

class BaseSingleApiResponse {
  Map<String, dynamic>? data;
  String? error;

  BaseSingleApiResponse({
    this.data,
    this.error,
  });

  BaseSingleApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = json['data'];
      // throw Exception('model type not found in api response');
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // if (data != null) {
    //   map['data'] = data?.map((v) => v.toJson()).toList();
    // }
    map['error'] = error;
    return map;
  }
}
