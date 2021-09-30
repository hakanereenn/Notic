import 'package:hive/hive.dart';
part 'notemodal.g.dart';

@HiveType(typeId: 0)
class NoteModal extends HiveObject {
  @HiveField(0)
   String title;
  @HiveField(1)
   String content;
  @HiveField(2)
  bool isImportant;
  @HiveField(3)
   bool isArchive;
  @HiveField(4)
   DateTime dateTime;
  @HiveField(5)
  int tagId;
  NoteModal(
      {this.title,
      this.content,
      this.isImportant,
      this.isArchive,
      this.dateTime,
      this.tagId});
}
