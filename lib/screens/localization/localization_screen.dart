// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationScreen extends StatefulWidget {
  LocalizationScreen({Key? key}) : super(key: key);

  @override
  State<LocalizationScreen> createState() => _LocalizationScreenState();
}

class _LocalizationScreenState extends State<LocalizationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localization'),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.hello),
        // child: Text('ສະ​ບາຍ​ດີ​, ເຈົ້າ​ສະ​ບາຍ​ດີ​ບໍ່?'),
      ),
    );
  }
}