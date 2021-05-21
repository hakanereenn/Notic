// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagmodal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TagModalAdapter extends TypeAdapter<TagModal> {
  @override
  final int typeId = 1;

  @override
  TagModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TagModal(
      tagName: fields[0] as String,
      color: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TagModal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.tagName)
      ..writeByte(1)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
