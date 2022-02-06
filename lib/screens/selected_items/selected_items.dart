import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_table_app/bloc/get_menu_items_bloc/get_menu_items_bloc.dart';
import 'package:restaurant_table_app/main.dart';
import 'package:restaurant_table_app/models/selected_items_list_model.dart';
import 'package:restaurant_table_app/repository/get_menu_items_repository.dart';
import 'package:restaurant_table_app/screens/place_order_screen/place_order_screen.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class SelectedItemsScreen extends StatefulWidget {
  final dynamic tableName;
  const SelectedItemsScreen({Key? key, @required this.tableName})
      : super(key: key);

  @override
  State<SelectedItemsScreen> createState() => _SelectedItemsScreenState();
}

class _SelectedItemsScreenState extends State<SelectedItemsScreen> {
  List<SelectedItemsListDatum> previousList = [];
  List<SelectedItemsListDatum> displayList = [];
  double? totalAmount = 0.0;
  @override
  void initState() {
    previousList = box.get(widget.tableName) ?? [];

    for (var items in previousList) {
      totalAmount =
          totalAmount! + (items.salesRate! * int.tryParse(items.qty!)!);
    }

    displayList = displayList + previousList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order for ${widget.tableName}"),
        actions: [
          displayList.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      totalAmount = 0.0;
                      previousList.clear();
                      displayList.clear();
                    });
                  },
                  icon: const Icon(Icons.clear),
                )
              : Container(),
        ],
      ),
      floatingActionButton: displayList.isEmpty
          ? FloatingActionButton(
              onPressed: () async {
                var data = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => GetMenuItemsBloc(
                          getMenuItemsRepository: GetMenuItemsRepository())
                        ..add(FetchMenuItems(searchItemName: "")),
                      child: PlaceOrderScreen(
                        tableName: widget.tableName,
                      ),
                    ),
                  ),
                );
                previousList = box.get(widget.tableName) ?? [];

                for (var items in previousList) {
                  totalAmount = totalAmount! +
                      (items.salesRate! * int.tryParse(items.qty!)!);
                }

                displayList = displayList + previousList;
                setState(() {
                  print("Data: $data");
                });
              },
              child: Image.asset(
                'assets/serving.png',
                height: 40,
                width: 40,
              ),
            )
          : Container(),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: displayList.isEmpty
            ? Center(
                child: Text("Please add an item"),
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    displayList[index].itemName!,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    "Rs. ${displayList[index].salesRate! * int.tryParse(displayList[index].qty!)!}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                              Text("Quantity: " + displayList[index].qty!),
                              Text("Remarks: " + displayList[index].remarks!),
                            ],
                          ),
                        ));
                      },
                    ),
                  ),
                  totalAmount != 0.0
                      ? Row(
                          children: [
                            Text(
                              "Rs. $totalAmount",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        )
                      : Container(),
                  UIHelper.verticalSpaceSmall(context),
                  displayList.isEmpty
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            UIHelper.horizontalSpaceSmall(context),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                                onPressed: () {
                                  setState(() {
                                    box.delete(widget.tableName);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: const Text("PAY BILL"),
                                ),
                              ),
                            ),
                            UIHelper.horizontalSpaceSmall(context),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                onPressed: () async {
                                  var data = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => GetMenuItemsBloc(
                                            getMenuItemsRepository:
                                                GetMenuItemsRepository())
                                          ..add(FetchMenuItems(
                                              searchItemName: "")),
                                        child: PlaceOrderScreen(
                                          tableName: widget.tableName,
                                        ),
                                      ),
                                    ),
                                  );
                                  previousList =
                                      box.get(widget.tableName) ?? [];

                                  print(previousList.length);
                                  totalAmount = 0.0;

                                  for (var items in previousList) {
                                    totalAmount = totalAmount! +
                                        (items.salesRate! *
                                                int.tryParse(items.qty!)!)
                                            .toDouble();
                                  }

                                  displayList = previousList;
                                  setState(() {
                                    print("Data: $data");
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: const Text("ADD ITEM"),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
      ),
    );
  }
}
