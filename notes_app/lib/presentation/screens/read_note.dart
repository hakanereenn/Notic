import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/domain/models/notemodal.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:notes_app/presentation/routes/app_routes.dart';
import 'package:notes_app/presentation/widgets/alert_dialog.dart';
import 'package:notes_app/presentation/widgets/read_note/floatActionButton.dart';
import 'package:provider/provider.dart';

class ReadNote extends StatefulWidget {
  @override
  _ReadNoteState createState() => _ReadNoteState();
}

class _ReadNoteState extends State<ReadNote> {
  @override
  Widget build(BuildContext context) {
    final noteId = ModalRoute.of(context).settings.arguments as int;
    final loadedNote = context.watch<MainProvider>().getNote(noteId);
    final String fullText = '''${loadedNote.title ?? " "}
${loadedNote.content ?? " "} ''';
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    copyFunction(GlobalKey<ScaffoldState> _scaffoldKey) {
      FlutterClipboard.copy(fullText).then((value) => print(fullText));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text("copy").tr(),
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                return copyFunction(_scaffoldKey);
              }),
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.pushReplacementNamed(
                  context, AppRoutes.editNote,
                  arguments: loadedNote.key)),
        ],
      ),
      floatingActionButton: FAB(fullText, noteId, () {
        return showDialog(
          context: context,
          builder: (ctx) => alertDialog(
            context,
            Text(
              "sureDeleteNote".tr(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            () async {
              Navigator.of(context).pop();
              context
                  .read<MainProvider>()
                  .deleteNote(loadedNote.key, loadedNote.tagId);
            },
          ),
        );
      }),
      body: buildInkWell(copyFunction, _scaffoldKey, loadedNote, context),
    );
  }

  InkWell buildInkWell(
      copyFunction(GlobalKey<ScaffoldState> _scaffoldKey),
      GlobalKey<ScaffoldState> _scaffoldKey,
      NoteModal loadedNote,
      BuildContext context) {
    String now = DateFormat('yyyy-MM-dd HH:mm')
        .format(loadedNote.dateTime ?? DateTime.now());
    return InkWell(
      onLongPress: () => copyFunction(_scaffoldKey),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                now,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          loadedNote.title == null || loadedNote.title.isEmpty ?? false
              ? SizedBox(
                  width: 10,
                )
              : Text(
                  loadedNote.title ?? ' ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
          loadedNote.content == null || loadedNote.content.isEmpty ?? false
              ? SizedBox(
                  width: 10,
                )
              : Text(
                  loadedNote.content ?? ' ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
        ],
      ),
    );
  }
}
