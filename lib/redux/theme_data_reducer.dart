
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
final ThemeDataReducer=combineReducers<ThemeData>([
  TypedReducer<ThemeData,RefreshTemeDataAction>(_refresh)]);

ThemeData _refresh(ThemeData themeData,action){
  themeData=action.themeData;
  return themeData;
}

class RefreshTemeDataAction{
  final ThemeData themeData;
  RefreshTemeDataAction(this.themeData);
}