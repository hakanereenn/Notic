import 'package:flutter/material.dart';
import 'package:notes_app/domain/models/notemodal.dart';
import 'package:notes_app/presentation/providers/add_note_provider.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:notes_app/presentation/widgets/add_note/note_textfield.dart';
import 'package:notes_app/presentation/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class EditNote extends StatelessWidget {
  Future<void> _onUpdate(BuildContext context, NoteModal note) async {
    final formProvider = context.read<AddNoteProvider>();
    formProvider.isArchive == null
        ? formProvider.setArchive(note.isArchive)
        : formProvider.isArchive;
    formProvider.isImportant == null
        ? formProvider.setImportant(note.isImportant)
        : formProvider.isImportant;
    formProvider.title == null
        ? formProvider.setTitle(note.title)
        : formProvider.title;
    formProvider.content == null
        ? formProvider.setContent(text: note.content)
        : formProvider.content;
    formProvider.setDate();
    final formModel = NoteModal(
      title: formProvider.title,
      content: formProvider.content,
      tagId: note.tagId,
      dateTime: formProvider.dateTime,
      isArchive: formProvider.isArchive,
      isImportant: formProvider.isImportant,
    );
    await context.read<MainProvider>().editNote(formModel, note.key);
    print(note.tagId);
    print(formModel.isArchive);
  }

  @override
  Widget build(BuildContext context) {
    final noteId = ModalRoute.of(context).settings.arguments as int;
    final loadedNote = context.read<MainProvider>().getNote(noteId);

    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    titleController.text = loadedNote.title ?? '';
    contentController.text = loadedNote.content ?? '';

    return Consumer<AddNoteProvider>(
      builder: (context, state, widget) {
        return WillPopScope(
          onWillPop: () {
            _onUpdate(context, loadedNote).whenComplete(
              () => Navigator.of(context).pop(),
            );
            return Future.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  return showDialog(
                      context: context,
                      builder: (ctx) => alertDialog(
                            context,
                            Text(
                              "sureUpdateNote".tr(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            () => _onUpdate(context, loadedNote)
                                .whenComplete(() => Navigator.pop(context)),
                          ));
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    loadedNote.isImportant
                        ? Icons.thumb_up
                        : Icons.thumb_up_alt_outlined,
                  ),
                  onPressed: () => state
                      .setImportant(!loadedNote.isImportant)
                      .then((value) =>
                          loadedNote.isImportant = state.isImportant),
                ),
                IconButton(
                  icon: Icon(
                    loadedNote.isArchive ?? false
                        ? Icons.archive
                        : Icons.archive_outlined,
                  ),
                  onPressed: () {
                    state.setArchive(!loadedNote.isArchive).whenComplete(
                          () => loadedNote.isArchive = state.isArchive,
                        );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.save_alt,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () => _onUpdate(context, loadedNote)
                      .whenComplete(() => Navigator.pop(context)),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NoteTextField(
                  textEditingController: titleController,
                  hintText: 'Başlık',
                  onChanged: (text) => state.setTitle(text),
                  textStyle: Theme.of(context).textTheme.headline1,
                  autoFocus: true,
                  maxLines: 1,
                ),
                Expanded(
                  child: NoteTextField(
                    textEditingController: contentController,
                    hintText: 'İçerik',
                    onChanged: (text) => state.setContent(text: text),
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    autoFocus: false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
