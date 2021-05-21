import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController text;
  SearchBar(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: text,
        autofocus: false,
        onChanged: (String name) {
          print(name);
          context.read<MainProvider>().searchNote(text.text).then(
                context.read<MainProvider>().searchSuffixVisibilityTrue(),
              );
        },
        onSubmitted: (name) => {
          FocusScope.of(context).unfocus(),
        },
        style: Theme.of(context).textTheme.headline1,
        decoration: InputDecoration(
          suffixIcon: Visibility(
            visible: context.watch<MainProvider>().writeSearch,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                text.clear();
                context.read<MainProvider>().allLoadNotes();
                context.read<MainProvider>().searchSuffixVisibilityFalse();
              },
            ),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
          ),
          hintText: 'searchBarHint'.tr(),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
