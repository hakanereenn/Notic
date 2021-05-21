import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_app/domain/models/tagmodal.dart';
import 'package:notes_app/presentation/providers/add_note_provider.dart';
import 'package:provider/provider.dart';

class AddTagForm extends StatelessWidget {
  AddTagForm(this.tagController, this.colorList, {this.tagList});

  final TextEditingController tagController;
  final List colorList;

  final List<TagModal> tagList;
  @override
  Widget build(BuildContext context) {
    final prWatch = context.watch<AddNoteProvider>();
    final prRead = context.read<AddNoteProvider>();

    return Container(
      child: tagList.isEmpty
          ? AddTag(
              tagController: tagController,
              prRead: prRead,
              prWatch: prWatch,
              colorList: colorList,
              tagList: tagList,
            )
          : prWatch.addStatus
              ? AddTag(
                  tagController: tagController,
                  prRead: prRead,
                  prWatch: prWatch,
                  colorList: colorList,
                  tagList: tagList,
                )
              : ListTag(prWatch: prWatch, tagList: tagList, prRead: prRead),
    );
  }
}

class ListTag extends StatelessWidget {
  const ListTag({
    Key key,
    @required this.prWatch,
    @required this.tagList,
    @required this.prRead,
  }) : super(key: key);

  final AddNoteProvider prWatch;
  final List<TagModal> tagList;
  final AddNoteProvider prRead;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Spacer(flex: 1),
          Container(
            width: 300,
            child: DropdownButton<TagModal>(
                isExpanded: true,
                isDense: true,
                value: prWatch.tagModal,
                hint: Container(
                  width: 100,
                  child: Text(
                    "Etiket Seçiniz",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                items: tagList.map((TagModal tag) {
                  return DropdownMenuItem<TagModal>(
                    value: tag,
                    child: Row(
                      children: <Widget>[
                        Text(
                          tag.tagName,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        )
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (s) {
                  prRead.setTag(s.tagName);
                  prRead.setTagModal(s);
                }),
          ),
          Spacer(flex: 2),
          IconButton(
              icon: Icon(prWatch.addStatus ? Icons.list : Icons.add),
              onPressed: () {
                prRead.setAddStatus(!prWatch.addStatus);
              }),
          Spacer(flex: 1),
        ],
      ),
    ]);
  }
}

class AddTag extends StatelessWidget {
  const AddTag({
    Key key,
    @required this.tagController,
    @required this.prRead,
    @required this.prWatch,
    @required this.colorList,
    @required this.tagList,
  }) : super(key: key);

  final TextEditingController tagController;
  final AddNoteProvider prRead;
  final AddNoteProvider prWatch;
  final List colorList;
  final List tagList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            TextField(
              controller: tagController,
              autofocus: false,
              onSubmitted: (a) => {
                FocusScope.of(context).unfocus(),
              },
              decoration: InputDecoration(
                hintText: 'tag'.tr(),
                hintStyle: Theme.of(context).textTheme.bodyText1,
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.tag,
                  color: Theme.of(context).accentColor,
                ),
              ),
              onChanged: (text) => prRead.setTag(text),
            ),
            Positioned(
              right: 10,
              child: tagList.isEmpty
                  ? SizedBox()
                  : IconButton(
                      icon: Icon(prWatch.addStatus ? Icons.list : Icons.add),
                      onPressed: () {
                        prRead.setAddStatus(!prWatch.addStatus);
                      }),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.color_lens,
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colorList.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: () => {
                        prRead.setColor(i),
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOutCirc,
                        width:
                            colorList[prWatch.color] == colorList[i] ? 80 : 40,
                        height: 20,
                        color: colorList[prWatch.color] == colorList[i]
                            ? Color(colorList[i])
                            : Color(colorList[i]).withOpacity(0.8),
                        child: colorList[prWatch.color] == colorList[i]
                            ? Center(
                                child: Icon(Icons.done_all_sharp),
                              )
                            : Text(''),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
