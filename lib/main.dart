// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:p1label/routers.dart';
import 'package:p1label/themes/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:p1label/provider/app_locale.dart';
import 'package:provider/provider.dart';

var userStep;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userStep = sharedPreferences.getInt('userStep');

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppLocale(),
      child: Consumer<AppLocale>(builder: (context, locale, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'P1 Print Label',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale.locale,
          theme: appTheme(),
          initialRoute: userStep == 1 ? '/home': '/branchcode',
          // initialRoute: userStep == 1 ? '/home': '/localization',
          // initialRoute: userStep == 1 ? '/home': '/localizationselected',
          routes: routes,
        );
      }),
    );
  }
}