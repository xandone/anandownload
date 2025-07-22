// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoEntityAdapter extends TypeAdapter<VideoEntity> {
  @override
  final int typeId = 1;

  @override
  VideoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoEntity(
      id: fields[0] as String?,
      size: fields[4] as int,
      timelength: fields[5] as int?,
      url: fields[3] as String?,
      fileName: fields[1] as String?,
      pic: fields[2] as String?,
      pSize: fields[6] as int,
      progress: fields[7] as double,
      basePath: fields[9] as String,
      savePath: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VideoEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fileName)
      ..writeByte(2)
      ..write(obj.pic)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.timelength)
      ..writeByte(6)
      ..write(obj.pSize)
      ..writeByte(7)
      ..write(obj.progress)
      ..writeByte(8)
      ..write(obj.savePath)
      ..writeByte(9)
      ..write(obj.basePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
