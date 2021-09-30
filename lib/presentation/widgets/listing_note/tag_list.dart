import 'package:flutter/material.dart';
import 'package:notes_app/domain/models/tagmodal.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:notes_app/presentation/routes/app_routes.dart';
import 'package:notes_app/presentation/widgets/listing_note/tag_item_list.dart';
import 'package:provider/provider.dart';

class TagList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pr = context.watch<MainProvider>();
    return Container(
      height: 50,
      child: (pr.tagList.length > 0)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ListView.builder(
                    //   padding: EdgeInsets.all(5),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) =>
                        tagItemList(pr.tagList[i], i, context),
                    itemCount: pr.tagList.length,
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.detailTagList))
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                tagItemList(
                    TagModal(
                      tagName: "#",
                    ),
                    0,
                    context),
              ],
            ),
    );
  }
}
