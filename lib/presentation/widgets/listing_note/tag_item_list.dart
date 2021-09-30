import 'package:flutter/material.dart';
import 'package:notes_app/domain/models/tagmodal.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:provider/provider.dart';

Widget tagItemList(TagModal tag, int i, BuildContext context) {
  final pr = context.read<MainProvider>();

  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: ChoiceChip(
      padding: EdgeInsets.all(10),
      label: Text(
        tag.tagName,
        style: TextStyle(
          color: pr.tagValue == i
              ? Theme.of(context).primaryColor
              : Theme.of(context).accentColor,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      selectedColor: Theme.of(context).primaryColorLight,
      selected: pr.tagValue == i,
      onSelected: (bool selected) async {
        if (selected) {
          pr.setTagValue = selected ? i : null;
          await context.read<MainProvider>().loadNotes(tag.key);
        } else {
          pr.setTagValue = selected ? i : null;
          await context.read<MainProvider>().allLoadNotes();
        }
      },
    ),
  );
}
