import 'package:flutter/material.dart';
import 'package:fluttershow/common/localizations.dart';
import 'package:fluttershow/common/string_base.dart';


class LocaleManager{

  static MStringBase getLocale(BuildContext context){
      return MLocalizations.of(context).currentLocalized;
  }

}
