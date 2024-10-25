import '../src/enum.dart';

class LanguageModel {
  String? key;
  String? text;
  LanguageCode? code;

  LanguageModel({this.key, this.text, this.code});

  LanguageModel.fromJson({Map<String, dynamic>? data}) {
    if (data != null) {
      key = data['key'];
      text = data['text'];
      code = data['code'];
    }
  }

  Map<String, dynamic> toJson() {
    return {'key': key, 'text': text, 'code': code};
  }
}
