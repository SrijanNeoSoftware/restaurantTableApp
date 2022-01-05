import 'package:flutter/material.dart';

class SelectedItemsListDatum {
  SelectedItemsListDatum({
    @required this.itemCode,
    @required this.itemName,
    @required this.unitCode,
    @required this.salesRate,
    @required this.itemImage,
    @required this.remarks,
  });

  int? itemCode;
  String? itemName;
  String? unitCode;
  int? salesRate;
  String? itemImage;
  String? remarks;
}
