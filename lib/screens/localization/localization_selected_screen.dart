// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:p1label/helper/shared_pref.dart';
import 'package:p1label/models/app_language.dart';
import 'package:p1label/provider/app_locale.dart';
import 'package:p1label/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationSelectedScreen extends StatefulWidget {
  LocalizationSelectedScreen({Key? key}) : super(key: key);

  @override
  State<LocalizationSelectedScreen> createState() => _LocalizationSelectedScreenState();
}

class _LocalizationSelectedScreenState extends State<LocalizationSelectedScreen> {

  late String currentDefaultSystemLocale;
  int selectedLangIndex = 0;
  var _appLocale;

  late AppLanguage dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = AppLanguage.languages().first;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocale = Provider.of<AppLocale>(context);
    getLocale().then((locale) {
      _appLocale.changeLocale(Locale(locale.languageCode));
      dropdownValue = AppLanguage.languages().firstWhere(
          (element) => element.languageCode == locale.languageCode);
      _setFlag();
    });
  }

  void _setFlag() {
    currentDefaultSystemLocale = _appLocale.locale.languageCode.split('_')[0];
    setState(() {
      selectedLangIndex = _getLangIndex(currentDefaultSystemLocale);
    });
  }

  int _getLangIndex(String currentDefaultSystemLocale) {
    int _langIndex = 0;
    switch (currentDefaultSystemLocale) {
      case 'en':
        _langIndex = 0;
        break;
      case 'th':
        _langIndex = 1;
        break;
      case 'lo':
        _langIndex = 2;
        break;
    }
    return _langIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(AppLocalizations.of(context)!.changelang),
                  SizedBox(width: 20.0,),
                  DropdownButton<AppLanguage>(
                    value: dropdownValue,
                    iconSize: 40,
                    style: TextStyle(fontSize: 16),
                    onChanged: (AppLanguage? language) {
                      dropdownValue = language!;
                      _appLocale.changeLocale(Locale(language.languageCode));
                      _setFlag();
                      setLocale(language.languageCode);
                    },
                    items: AppLanguage.languages()
                        .map<DropdownMenuItem<AppLanguage>>(
                          (e) => DropdownMenuItem<AppLanguage>(
                              value: e,
                              child: Text(
                                e.name,
                                style: TextStyle(color: primaryColor),
                              )),
                        )
                        .toList(),
                  ),
                ],
              ),
              Text(
                AppLocalizations.of(context)!.hello,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}