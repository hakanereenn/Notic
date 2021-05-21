import 'package:flutter/material.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:notes_app/presentation/widgets/listing_note/tag_detail_item.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
class TagDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pr = context.watch<MainProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "tagList",
          style: Theme.of(context).textTheme.headline2,
        ).tr(),
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          return TagDetailItem(pr.tagList[i], pr.colorList);
        },
        itemCount: pr.tagList.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
