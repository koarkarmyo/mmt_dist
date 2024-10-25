import 'dart:convert';

/// jsonrpc : "2.0"
/// id : null
/// error : {"code":200,"message":"Odoo Server Error","data":{"name":"odoo.exceptions.AccessDenied","debug":"Traceback (most recent call last):\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 1500, in _dispatch_nodb\n    result = request.dispatch()\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 687, in dispatch\n    result = self._call_function(**self.params)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 360, in _call_function\n    return self.endpoint(*args, **kwargs)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 916, in __call__\n    return self.method(*args, **kw)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 535, in response_wrap\n    response = f(*args, **kw)\n  File \"/opt/odoo15/odoo/addons/web/controllers/main.py\", line 1208, in authenticate\n    request.session.authenticate(db, login, password)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 1029, in authenticate\n    uid = odoo.registry(db)['res.users'].authenticate(db, login, password, env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 724, in authenticate\n    uid = cls._login(db, login, password, user_agent_env=user_agent_env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 699, in _login\n    user._check_credentials(password, user_agent_env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 1649, in _check_credentials\n    return super()._check_credentials(password, user_agent_env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 395, in _check_credentials\n    raise AccessDenied()\nException\n\nThe above exception was the direct cause of the following exception:\n\nTraceback (most recent call last):\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 643, in _handle_exception\n    return super(JsonRequest, self)._handle_exception(exception)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 301, in _handle_exception\n    raise exception.with_traceback(None) from new_cause\nodoo.exceptions.AccessDenied: Access Denied\n","message":"Access Denied","arguments":["Access Denied"],"context":{}}}

OdooErrorResponse odooErrorResponseFromJson(String str) =>
    OdooErrorResponse.fromJson(json.decode(str));

String odooErrorResponseToJson(OdooErrorResponse data) =>
    json.encode(data.toJson());

class OdooErrorResponse<T> {
  OdooErrorResponse({
    String? jsonrpc,
    int? id,
    Error? error,
    List<T>? result,
  }) {
    _jsonrpc = jsonrpc;
    _id = id;
    _error = error;
    _result = result;
  }

  OdooErrorResponse.fromJson(Map<String, dynamic> json) {
    _jsonrpc = json['jsonrpc'];
    _id = json['id'];
    _error = json['error'] != null ? Error.fromJson(json['error']) : null;
    if (json['result'] != null) {
      _result = [];
      if(T == String) {
        List<String> stringList = [];
        json['result'].forEach((e) {
          stringList.add(e as String);
        });
        _result = stringList as List<T>;
      } else {

      }
    }
  }

  String? _jsonrpc;
  int? _id;
  Error? _error;
  List<T>? _result;

  OdooErrorResponse copyWith({
    String? jsonrpc,
    int? id,
    Error? error,
    List<T>? result,
  }) =>
      OdooErrorResponse(
        jsonrpc: jsonrpc ?? _jsonrpc,
        id: id ?? _id,
        error: error ?? _error,
        result: result ?? _result,
      );

  String? get jsonrpc => _jsonrpc;

  dynamic get id => _id;

  Error? get error => _error;

  List<T>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonrpc'] = _jsonrpc;
    map['id'] = _id;
    if (_error != null) {
      map['error'] = _error?.toJson();
    }
    return map;
  }
}

/// code : 200
/// message : "Odoo Server Error"
/// data : {"name":"odoo.exceptions.AccessDenied","debug":"Traceback (most recent call last):\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 1500, in _dispatch_nodb\n    result = request.dispatch()\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 687, in dispatch\n    result = self._call_function(**self.params)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 360, in _call_function\n    return self.endpoint(*args, **kwargs)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 916, in __call__\n    return self.method(*args, **kw)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 535, in response_wrap\n    response = f(*args, **kw)\n  File \"/opt/odoo15/odoo/addons/web/controllers/main.py\", line 1208, in authenticate\n    request.session.authenticate(db, login, password)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 1029, in authenticate\n    uid = odoo.registry(db)['res.users'].authenticate(db, login, password, env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 724, in authenticate\n    uid = cls._login(db, login, password, user_agent_env=user_agent_env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 699, in _login\n    user._check_credentials(password, user_agent_env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 1649, in _check_credentials\n    return super()._check_credentials(password, user_agent_env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 395, in _check_credentials\n    raise AccessDenied()\nException\n\nThe above exception was the direct cause of the following exception:\n\nTraceback (most recent call last):\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 643, in _handle_exception\n    return super(JsonRequest, self)._handle_exception(exception)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 301, in _handle_exception\n    raise exception.with_traceback(None) from new_cause\nodoo.exceptions.AccessDenied: Access Denied\n","message":"Access Denied","arguments":["Access Denied"],"context":{}}

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
  Error({
    int? code,
    String? message,
    Data? data,
  }) {
    _code = code;
    _message = message;
    _data = data;
  }

  Error.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  int? _code;
  String? _message;
  Data? _data;

  Error copyWith({
    int? code,
    String? message,
    Data? data,
  }) =>
      Error(
        code: code ?? _code,
        message: message ?? _message,
        data: data ?? _data,
      );

  int? get code => _code;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// name : "odoo.exceptions.AccessDenied"
/// debug : "Traceback (most recent call last):\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 1500, in _dispatch_nodb\n    result = request.dispatch()\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 687, in dispatch\n    result = self._call_function(**self.params)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 360, in _call_function\n    return self.endpoint(*args, **kwargs)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 916, in __call__\n    return self.method(*args, **kw)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 535, in response_wrap\n    response = f(*args, **kw)\n  File \"/opt/odoo15/odoo/addons/web/controllers/main.py\", line 1208, in authenticate\n    request.session.authenticate(db, login, password)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 1029, in authenticate\n    uid = odoo.registry(db)['res.users'].authenticate(db, login, password, env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 724, in authenticate\n    uid = cls._login(db, login, password, user_agent_env=user_agent_env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 699, in _login\n    user._check_credentials(password, user_agent_env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 1649, in _check_credentials\n    return super()._check_credentials(password, user_agent_env)\n  File \"/opt/odoo15/odoo/odoo/addons/base/models/res_users.py\", line 395, in _check_credentials\n    raise AccessDenied()\nException\n\nThe above exception was the direct cause of the following exception:\n\nTraceback (most recent call last):\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 643, in _handle_exception\n    return super(JsonRequest, self)._handle_exception(exception)\n  File \"/opt/odoo15/odoo/odoo/http.py\", line 301, in _handle_exception\n    raise exception.with_traceback(None) from new_cause\nodoo.exceptions.AccessDenied: Access Denied\n"
/// message : "Access Denied"
/// arguments : ["Access Denied"]
/// context : {}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? name,
    String? debug,
    String? message,
    List<String>? arguments,
    dynamic context,
  }) {
    _name = name;
    _debug = debug;
    _message = message;
    _arguments = arguments;
    _context = context;
  }

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _debug = json['debug'];
    _message = json['message'];
    _arguments =
        json['arguments'] != null ? json['arguments'].cast<String>() : [];
    _context = json['context'];
  }

  String? _name;
  String? _debug;
  String? _message;
  List<String>? _arguments;
  dynamic _context;

  Data copyWith({
    String? name,
    String? debug,
    String? message,
    List<String>? arguments,
    dynamic context,
  }) =>
      Data(
        name: name ?? _name,
        debug: debug ?? _debug,
        message: message ?? _message,
        arguments: arguments ?? _arguments,
        context: context ?? _context,
      );

  String? get name => _name;

  String? get debug => _debug;

  String? get message => _message;

  List<String>? get arguments => _arguments;

  dynamic get context => _context;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['debug'] = _debug;
    map['message'] = _message;
    map['arguments'] = _arguments;
    map['context'] = _context;
    return map;
  }
}
