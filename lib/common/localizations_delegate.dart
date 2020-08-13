import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttershow/common/localizations.dart';


class MLocalizationDelegate extends LocalizationsDelegate<MLocalizations> {
  MLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['zh', 'en'].contains(locale.languageCode);
  }

  @override
  Future<MLocalizations> load(Locale locale) {
    return SynchronousFuture<MLocalizations>(MLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<MLocalizations> old) {
    return false;
  }

  //todo 静态代理
  static MLocalizationDelegate delegate = MLocalizationDelegate();
}