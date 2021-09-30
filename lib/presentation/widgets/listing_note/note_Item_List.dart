import 'package:flutter/material.dart';
import 'package:notes_app/domain/models/notemodal.dart';
import 'package:notes_app/presentation/routes/app_routes.dart';

Widget noteItemList(
    NoteModal note, BuildContext context, int color, List colorList) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    height: 130,
    child: Container(
      height: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 27,
            color: Color(0xff737373),
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          onTap: () => Navigator.of(context)
              .pushNamed(AppRoutes.readNote, arguments: note.key),
          leading: Container(
            height: 90,
            width: 20,
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              color: Color(colorList[color ?? 0]),
            ),
          ),
          trailing: Container(
            height: 110,
            width: 30,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Icon(Icons.keyboard_arrow_right),
          ),
          title: Text(
            note.title ?? "",
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            note.content ?? '',
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ),
  );
}
