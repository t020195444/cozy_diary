// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UidAndState.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UidAndStateAdapter extends TypeAdapter<UidAndState> {
  @override
  final int typeId = 0;

  @override
  UidAndState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UidAndState(
      uid: fields[0] as String,
      isLogin: fields[1] == null ? false : fields[1] as bool,
      themeMode: fields[2] == null ? 'system' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UidAndState obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.isLogin)
      ..writeByte(2)
      ..write(obj.themeMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UidAndStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
