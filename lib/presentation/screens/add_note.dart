import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_app/domain/models/notemodal.dart';
import 'package:notes_app/domain/models/tagmodal.dart';
import 'package:notes_app/presentation/providers/add_note_provider.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:notes_app/presentation/routes/app_routes.dart';
import 'package:notes_app/presentation/widgets/add_note/note_textfield.dart';
import 'package:notes_app/presentation/widgets/add_note/tag_form.dart';

import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  Future<void> onSubmit(BuildContext context,
      {TextEditingController title, TextEditingController content}) async {
    if (title.text.isNotEmpty || content.text.isNotEmpty) {
      final formProvider = context.read<AddNoteProvider>();
      await context.read<AddNoteProvider>().setDateAndBool();
      await context.read<MainProvider>().createNoteTag(
            TagModal(
              tagName: formProvider.tagName,
              color: formProvider.color,
            ),
            NoteModal(
              title: formProvider.title,
              content: formProvider.content,
              dateTime: formProvider.dateTime,
              isArchive: formProvider.isArchive,
              isImportant: formProvider.isImportant,
            ),
          );
      context.read<MainProvider>().addTagVisibility(s: false);
      TagModal tag;
      context.read<AddNoteProvider>().setAddStatus(false);
      context.read<AddNoteProvider>().setTagModal(tag);
    }
  }

  void onControllerSubmit(TextEditingController title,
      TextEditingController content, BuildContext context) async {
    if (title.text.isNotEmpty || content.text.isNotEmpty) {
      content.clear();
      title.clear();
      print(title.text.isEmpty);
      print(content.text.isEmpty);
      onSubmit(context, content: content, title: title);
    }
    Navigator.pop(context);
  }

  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController tagController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    FocusNode _contentFocusNode = FocusNode();
    return ChangeNotifierProvider(
      create: (_) => AddNoteProvider(),
      builder: (context, _) => WillPopScope(
        onWillPop: () {
          TagModal tag;
          context.read<AddNoteProvider>().setAddStatus(false);
          context.read<AddNoteProvider>().setTagModal(tag);
          context.read<MainProvider>().addTagVisibility(s: false);
          onControllerSubmit(titleController, contentController, context);
          return Future.value(false);
        },
        child: Scaffold(
          key: scaffoldState,
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                TagModal tag;
                context.read<AddNoteProvider>().setAddStatus(false);
                context.read<AddNoteProvider>().setTagModal(tag);
                context.read<MainProvider>().addTagVisibility(s: false);
                onControllerSubmit(titleController, contentController, context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.home, (route) => false),
              ),
              IconButton(
                icon: Icon(
                  Icons.tag,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  context.read<MainProvider>().addTagVisibility();
                  // _onTagForm(context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.save_alt,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => onSubmit(context,
                        title: titleController, content: contentController)
                    .whenComplete(
                  () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: context.watch<MainProvider>().addTagShow,
                  child: AddTagForm(
                    tagController,
                    context.read<MainProvider>().colorList,
                    tagList: context.read<MainProvider>().tagList,
                  ),
                ),
                NoteTextField(
                  hintText: 'title'.tr(),
                  onSubmitted: (n) {
                    FocusScope.of(context).requestFocus(_contentFocusNode);
                  },
                  onChanged: (text) =>
                      context.read<AddNoteProvider>().setTitle(text),
                  textStyle: Theme.of(context).textTheme.headline1,
                  autoFocus: false,
                  textEditingController: titleController,
                  maxLines: 1,
                ),
                Expanded(
                  child: NoteTextField(
                    textEditingController: contentController,
                    hintText: 'content'.tr(),
                    onChanged: (text) =>
                        context.read<AddNoteProvider>().setContent(text: text),
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    autoFocus: false,
                    focusNode: _contentFocusNode,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
