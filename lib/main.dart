import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttershow/common/localizations_delegate.dart';
import 'package:fluttershow/common/theme_manager.dart';
import 'package:fluttershow/navigator/tab_navigator.dart';
import 'package:fluttershow/redux/app_starte.dart';
import 'package:redux/redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() => runApp(FlutterMyApp());

class FlutterMyApp extends StatelessWidget {
  final store = Store<AppState>(
      appReducer,
      initialState: AppState(
          themeData: ThemeManager.getThemeData(MColors.primarySwatch),
          locale: Locale("zh", "CH")
      )
  );


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: StoreBuilder<AppState>(builder: (context, store) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              MLocalizationDelegate.delegate,
            ],
            locale: store.state.locale,
            supportedLocales: [store.state.locale],
            theme: store.state.themeData,
            home: TabHome(),
          );
        }));
  }
}

class MLocalizations extends StatefulWidget{
  final Widget child;
  MLocalizations({Key key,this.child}):super(key:key);

  @override
  State<StatefulWidget> createState() {
        return _LocalizationsState();
  }
}
class _LocalizationsState extends State<MLocalizations>{
  @override
  Widget build(BuildContext context) {
      return StoreBuilder<AppState>(builder: (context,store)
      {
        return Localizations.override(
          context: context,
          locale: store.state.locale,
          child: widget.child,
        );
      });
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }
}
