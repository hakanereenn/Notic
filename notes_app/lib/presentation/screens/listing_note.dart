import 'package:flutter/material.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:notes_app/presentation/routes/app_routes.dart';
import 'package:notes_app/presentation/widgets/listing_note/listining_note_body.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ListingNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        toolbarHeight: heightSize * 0.08,
        centerTitle: true,
        title: _appBarTitle(widthSize, heightSize, context),
        actions: [_moreVertIconButton(heightSize, widthSize, context)],
      ),
      floatingActionButton: _listiningFAB(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListiningNoteBody(),
    );
  }
}

Widget _listiningFAB(BuildContext context) {
  return FloatingActionButton(
    heroTag: null,
    onPressed: () => Navigator.pushNamed(context, AppRoutes.addNote),
    child: Icon(
      Icons.add,
      color: Theme.of(context).primaryColor,
    ),
  );
}

Widget _appBarTitle(double widthSize, double heightSize, BuildContext context) {
  void onTapNotlar() {
    context.read<MainProvider>().setHowPage(0);
    context.read<MainProvider>().setTitleBar = 'notes';
    context.read<MainProvider>().setVisibilitySearchAndTags = true;
    context.read<MainProvider>().allLoadNotes();
    Navigator.pop(context);
  }

  void onTapArchive() {
    context.read<MainProvider>().setHowPage(2);
    context.read<MainProvider>().setTitleBar = 'isArchiveNote';
    context.read<MainProvider>().setVisibilitySearchAndTags = false;
    context.read<MainProvider>().allLoadNotes();
    Navigator.pop(context);
  }

  void onTapImportant() {
    context.read<MainProvider>().setHowPage(1);
    context.read<MainProvider>().setTitleBar = 'isImportantNote';
    context.read<MainProvider>().setVisibilitySearchAndTags = false;
    context.read<MainProvider>().allLoadNotes();
    Navigator.pop(context);
  }

  final String title = context.watch<MainProvider>().titleBar;
  return Container(
    child: ListTile(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            height: 175,
            child: Column(
              children: [
                ListTile(
                  onTap: onTapNotlar,
                  title: Text(
                    'notes',
                    style: Theme.of(context).textTheme.headline2,
                  ).tr(),
                  leading:
                      Icon(Icons.book, color: Theme.of(context).accentColor),
                  trailing: CircleAvatar(
                    minRadius: 10,
                    maxRadius: 13,
                    backgroundColor: Theme.of(context).accentColor,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                ListTile(
                  onTap: onTapImportant,
                  title: Text(
                    'isImportantNote',
                    style: Theme.of(context).textTheme.headline2,
                  ).tr(),
                  leading: Icon(Icons.thumb_up,
                      color: Theme.of(context).accentColor),
                  trailing: CircleAvatar(
                    minRadius: 10,
                    maxRadius: 13,
                    backgroundColor: Theme.of(context).accentColor,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                ListTile(
                  onTap: onTapArchive,
                  title: Text(
                    'isArchiveNote',
                    style: Theme.of(context).textTheme.headline2,
                  ).tr(),
                  leading:
                      Icon(Icons.archive, color: Theme.of(context).accentColor),
                  trailing: CircleAvatar(
                    minRadius: 10,
                    maxRadius: 13,
                    backgroundColor: Theme.of(context).accentColor,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.tr(),
            style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Colors.white,
                ),
          ),
          Icon(
            Icons.expand_more,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    ),
  );
}

Widget _moreVertIconButton(
    double heightSize, double widthSize, BuildContext context) {
  return IconButton(
    icon: Icon(
      Icons.settings,
      color: Theme.of(context).primaryColor,
    ),
    onPressed: () => Navigator.of(context).pushNamed(AppRoutes.setting),
  );
}
