import 'package:hive_flutter/adapters.dart';
part 'selected_items_list_model.g.dart';

@HiveType(typeId: 1)
class SelectedItemsListDatum {
  SelectedItemsListDatum({
    this.itemCode,
    this.itemName,
    this.unitCode,
    this.salesRate,
    this.itemImage,
    this.remarks,
    this.qty,
    this.table,
    this.tableCode,
  });

  @HiveField(0)
  int? itemCode;
  @HiveField(1)
  String? itemName;
  @HiveField(2)
  String? unitCode;
  @HiveField(3)
  int? salesRate;
  @HiveField(4)
  String? itemImage;
  @HiveField(5)
  String? remarks;
  @HiveField(6)
  String? qty;
  @HiveField(7)
  String? table;
  @HiveField(8)
  String? tableCode;
}
