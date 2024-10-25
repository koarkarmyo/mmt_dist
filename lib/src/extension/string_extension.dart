
import '../../model/language_model.dart';
import '../mmt_application.dart';

extension StringExtension on String {
  String preferredLanguage() {
    LanguageModel? foundLanguage = MMTApplication.languageList.firstWhere(
          (element) => (element?.key == this &&
          element?.code == MMTApplication.languageNotifier.value),
      orElse: () => null,
    );
    return foundLanguage?.text ?? this;
  }
}