import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/domain/models/tagmodal.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:notes_app/presentation/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';

class TagDetailItem extends StatelessWidget {
  final TagModal tag;
  final List<int> colorList;

  const TagDetailItem(
    this.tag,
    this.colorList,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      shadowColor: Theme.of(context).primaryColorLight,
      elevation: 4,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Color(colorList[tag.color]),
            shape: BoxShape.circle,
          ),
          height: 25,
          width: 25,
          padding: EdgeInsets.all(20),
        ),
        title: Text(
          tag.tagName,
          style: Theme.of(context).textTheme.headline1,
        ),
        trailing: IconButton(
          onPressed: () {
            return showDialog(
              context: context,
              builder: (ctx) => alertDialog(
                ctx,
                Text(
                  "sureDeleteTag",
                  style: Theme.of(context).textTheme.bodyText1,
                ).tr(),
                () => context.read<MainProvider>().deleteTag(tag.key),
              ),
            );
          },
          icon: Icon(Icons.delete, color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
