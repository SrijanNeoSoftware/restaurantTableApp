// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_items_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectedItemsListDatumAdapter
    extends TypeAdapter<SelectedItemsListDatum> {
  @override
  final int typeId = 1;

  @override
  SelectedItemsListDatum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectedItemsListDatum(
      itemCode: fields[0] as int?,
      itemName: fields[1] as String?,
      unitCode: fields[2] as String?,
      salesRate: fields[3] as int?,
      itemImage: fields[4] as String?,
      remarks: fields[5] as String?,
      qty: fields[6] as String?,
      table: fields[7] as String?,
      tableCode: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SelectedItemsListDatum obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.itemCode)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.unitCode)
      ..writeByte(3)
      ..write(obj.salesRate)
      ..writeByte(4)
      ..write(obj.itemImage)
      ..writeByte(5)
      ..write(obj.remarks)
      ..writeByte(6)
      ..write(obj.qty)
      ..writeByte(7)
      ..write(obj.table)
      ..writeByte(8)
      ..write(obj.tableCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedItemsListDatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
