import '../../core/core.dart';

String makePricePersian(String text) {
  for (var i = 0; i < english.length; i++) {
    text = text.replaceAll(english[i], farsi[i]);
  }
  return text.split('.')[0];
}
