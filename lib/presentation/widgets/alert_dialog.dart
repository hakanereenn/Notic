import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget alertDialog(BuildContext context, Text content, Function onTap) {
  return AlertDialog(
    title: Text(
      "sure",
      style: Theme.of(context)
          .textTheme
          .headline1
          .copyWith(color: Theme.of(context).accentColor),
    ).tr(),
    content: content,
    backgroundColor: Theme.of(context).primaryColor,
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        child:
            Text('no', style: TextStyle(color: Theme.of(context).primaryColor))
                .tr(),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
        onPressed: () => {
          Navigator.pop(context, true),
          onTap(),
        },
        child: Text(
          'yes',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ).tr(),
      ),
    ],
  );
}
