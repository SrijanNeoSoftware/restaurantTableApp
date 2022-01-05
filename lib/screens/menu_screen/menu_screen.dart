import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_table_app/bloc/get_menu_items_bloc/get_menu_items_bloc.dart';
import 'package:restaurant_table_app/models/selected_items_list_model.dart';
import 'package:restaurant_table_app/repository/get_menu_items_repository.dart';
import 'package:restaurant_table_app/screens/place_order_screen/place_order_screen.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class MenuScreen extends StatefulWidget {
  final dynamic tableName;
  const MenuScreen({Key? key, @required this.tableName}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<SelectedItemsListDatum>? selectedItems = [];
  List<SelectedItemsListDatum>? displayList = [];
  double? totalAmount = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order for ${widget.tableName}"),
        actions: [
          displayList!.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      totalAmount = 0.0;
                      displayList!.clear();
                    });
                  },
                  icon: const Icon(Icons.clear),
                )
              : Container(),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: displayList!.length,
                itemBuilder: (context, index) {
                  if (displayList!.isEmpty) {
                    return const Center(
                      child: Text("Please add an item"),
                    );
                  } else {
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                displayList![index].itemName!,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                "Rs. ${displayList![index].salesRate!}",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                          Text(displayList![index].remarks!),
                        ],
                      ),
                    ));
                  }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {},
                    child: const Text("SAVE"),
                  ),
                ),
                UIHelper.horizontalSpaceSmall(context),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {},
                    child: const Text("DELIVERED"),
                  ),
                ),
                UIHelper.horizontalSpaceSmall(context),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () async {
                      selectedItems = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => GetMenuItemsBloc(
                                getMenuItemsRepository:
                                    GetMenuItemsRepository())
                              ..add(FetchMenuItems(searchItemName: "")),
                            child: const PlaceOrderScreen(),
                          ),
                        ),
                      );

                      displayList = displayList! + selectedItems!;
                      selectedItems!.forEach((element) =>
                          totalAmount = totalAmount! + element.salesRate!);
                      setState(() {});
                      selectedItems!.clear();
                    },
                    child: const Text("ADD"),
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
