import 'package:flutter/material.dart';
import 'package:fluttershow/redux/theme_data_reducer.dart';
import 'package:redux/redux.dart';
class MColors{
    static const String primaryValueString ="#333333";
    static const String primaryLightValueString ="#333333";
    static const String primaryDarkValueString ="#333333";
    static const String a ="#333333";
    static const String b ="#333333";

    static const int primaryValue =0xFFFFFFFF;
    static const int primaryLightValue =0xFFFFFFFF;
    static const int primaryDarkValue =0xFFFFFFFF;

    static const int c =0xFFFFFFFF;
    static const int d =0xFFFFFFFF;
    static const int e =0xFFFFFFFF;
    static const int f =0xFFFFFFFF;
    static const int g =0xFFFFFFFF;
    static const int h =0xFFFFFFFF;

    static const int mainBackgroundColor =c;
    static const int mainTextColor =d;

    static const MaterialColor primarySwatch=
        const MaterialColor(
            primaryValue,
        const<int,Color>{
              50:const Color(primaryLightValue),
              100:const Color(primaryLightValue),
              200:const Color(primaryLightValue),
              300:const Color(primaryLightValue),
              400:const Color(primaryLightValue),
              500:const Color(primaryValue),
              600:const Color(primaryDarkValue),
              700:const Color(primaryDarkValue),
              800:const Color(primaryDarkValue),
              900:const Color(primaryDarkValue),
        }
        );
}

class ThemeManager{
  static List<Color>getThemeListColor(){
      return[
        MColors.primarySwatch,
        Colors.brown,
        Colors.blue,
        Colors.teal,
        Colors.amber,
        Colors.blueGrey,
        Colors.deepOrange
      ];
    }
    static pushTheme(Store store,int index){
        ThemeData themeData;
      List<Color> colors=getThemeListColor();
      themeData=getThemeData(colors[index]);
      store.dispatch(new RefreshTemeDataAction(themeData));
    }

    static getThemeData(Color color){
        return ThemeData(primarySwatch: color,platform: TargetPlatform.android);
    }
}

