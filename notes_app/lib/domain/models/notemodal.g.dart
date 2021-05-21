// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notemodal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModalAdapter extends TypeAdapter<NoteModal> {
  @override
  final int typeId = 0;

  @override
  NoteModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModal(
      title: fields[0] as String,
      content: fields[1] as String,
      isImportant: fields[2] as bool,
      isArchive: fields[3] as bool,
      dateTime: fields[4] as DateTime,
      tagId: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.isImportant)
      ..writeByte(3)
      ..write(obj.isArchive)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.tagId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
