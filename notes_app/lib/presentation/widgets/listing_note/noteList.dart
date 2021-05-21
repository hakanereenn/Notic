import 'package:flutter/material.dart';
import 'package:notes_app/domain/models/notemodal.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:notes_app/presentation/widgets/listing_note/note_Item_List.dart';
import 'package:notes_app/presentation/widgets/listing_note/onLongSelect.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class NoteList extends StatelessWidget {
  void _onShowModalSheet(BuildContext context, NoteModal note) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return OnOperationSelect(note);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Consumer<MainProvider>(
                builder: (context, value, _) => value.noteList.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (_, i) => InkWell(
                            onLongPress: () =>
                                _onShowModalSheet(context, value.noteList[i]),
                            child: noteItemList(
                              value.noteList[i],
                              context,
                              value.getTagColor(value.noteList[i].tagId),
                              value.colorList,
                            )),
                        itemCount: value.noteList.length,
                      )
                    : Container(
                        child: Center(
                          child: Text(
                            value.emptyNote,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Theme.of(context).accentColor),
                          ).tr(),
                        ),
                      )),
          ),
        ],
      ),
    );
  }
}
