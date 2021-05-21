import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_app/domain/models/lang.dart';
import 'package:notes_app/presentation/providers/app_provider.dart';
import 'package:notes_app/presentation/widgets/AppConstant.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "setting",
          style: Theme.of(context).textTheme.headline2,
        ).tr(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'selectLanguage',
                style: Theme.of(context).textTheme.bodyText1,
              ).tr(),
              DropdownButton(
                items: Lang.getLang()
                    .map<DropdownMenuItem<Lang>>((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.country,
                          style: Theme.of(context).textTheme.bodyText1,
                        ).tr()))
                    .toList(),
                onChanged: (Lang lang) {
                  context.setLocale(lang.contryCode);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'theme',
                style: Theme.of(context).textTheme.bodyText1,
              ).tr(),
              Consumer<AppProvider>(
                builder: (_, pr, ch) => Switch(
                    value:
                        pr.theme == AppThemeConstant.darkTheme ? true : false,
                    onChanged: (v) {
                      v
                          ? pr.setTheme(AppThemeConstant.darkTheme, 'dark')
                          : pr.setTheme(AppThemeConstant.lightTheme, 'light');
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
