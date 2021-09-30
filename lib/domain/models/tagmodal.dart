import 'package:hive/hive.dart';

part 'tagmodal.g.dart';

@HiveType(typeId: 1)
class TagModal extends HiveObject {
  TagModal({this.tagName, this.color});

  @HiveField(0)
  String tagName;
  @HiveField(1)
  int color;
}
