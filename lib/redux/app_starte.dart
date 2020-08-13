import 'package:flutter/material.dart';
import 'package:fluttershow/redux/local_reducer.dart';
import 'package:fluttershow/redux/theme_data_reducer.dart';
import 'package:redux/redux.dart';
class AppState{
  ThemeData themeData;
  Locale locale;
  Locale platformLocale;
  AppState({this.themeData,this.locale});
}
AppState appReducer(AppState state,action){
    return AppState(
      themeData:ThemeDataReducer(state.themeData,action),
      locale: LocaleReducer(state.locale,action),
    );
}