import 'package:flutter/material.dart';
import 'package:notes_app/domain/models/notemodal.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../alert_dialog.dart';

class OnOperationSelect extends StatelessWidget {
  final NoteModal noteModal;
  OnOperationSelect(this.noteModal);
  @override
  Widget build(BuildContext context) {
    final noteOperation = context.read<MainProvider>();
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                  noteModal.isImportant
                      ? Icons.thumb_up
                      : Icons.thumb_up_alt_outlined,
                  color: Theme.of(context).accentColor),
              onPressed: () => noteOperation
                  .updateIsImportant(
                      noteModal.key, noteModal, !noteModal.isImportant)
                  .then((value) => Navigator.pop(context)),
            ),
            IconButton(
              icon: Icon(
                noteModal.isArchive ? Icons.archive : Icons.archive_outlined,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => noteOperation
                  .updateIsArchive(
                      noteModal.key, noteModal, !noteModal.isArchive)
                  .then((value) => Navigator.pop(context)),
            ),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (ctx) => alertDialog(
                        context,
                        Text(
                          "sureDeleteNote".tr(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        () => noteOperation.deleteNote(
                            noteModal.key, noteModal.tagId)),
                  ).whenComplete(
                    () => Navigator.of(context).pop(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
