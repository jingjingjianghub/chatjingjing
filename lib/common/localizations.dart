import 'package:flutter/material.dart';
import 'package:fluttershow/common/string_base.dart';
import 'package:fluttershow/common/string_en.dart';
import 'package:fluttershow/common/string_zh.dart';

class  MLocalizations{
  final Locale locale;
  MLocalizations(this.locale);

  static Map<String,MStringBase> _localizedValues={
    "en":new MStringEn(),
    "zh":new MStringZh(),
  };
  MStringBase get currentLocalized{
    return _localizedValues[locale.languageCode];
  }
  static MLocalizations of(BuildContext context){
    return Localizations.of(context, MLocalizations);
  }
}
