import 'package:flutter/material.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:notes_app/presentation/widgets/listing_note/noteList.dart';
import 'package:notes_app/presentation/widgets/listing_note/tag_list.dart';
import 'package:provider/provider.dart';

class ListiningNoteBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pr = context.watch<MainProvider>().visibilitySearchAndTags;
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          /* Visibility(
            child: SearchBar(),//TODO search kısmı düzeltine kadar böyle kalacak 
            visible:pr,
          ),*/
          Visibility(
            child: TagList(),
            visible: pr,
          ),
          NoteList(),
        ],
      ),
    );
  }
}
