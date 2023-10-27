import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(children: [Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 170,
      color: theme.primaryColor,
      child: Text(
        "Settings",
        style: theme.textTheme.titleLarge,
      ),
    ),],);
  }
}
