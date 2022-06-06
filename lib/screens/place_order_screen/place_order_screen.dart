import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_table_app/bloc/get_menu_items_bloc/get_menu_items_bloc.dart';
import 'package:restaurant_table_app/bloc/get_table_list_bloc/get_table_list_bloc.dart';
import 'package:restaurant_table_app/models/get_items_list_model.dart';
import 'package:restaurant_table_app/models/post_response_model.dart';
import 'package:restaurant_table_app/models/selected_items_list_model.dart';
import 'package:restaurant_table_app/repository/post_sales_order.dart';
import 'package:restaurant_table_app/utils/dialog_utils.dart';
import 'package:restaurant_table_app/utils/snackbar_utils.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class PlaceOrderScreen extends StatefulWidget {
  // final SelectedItemsListDatum tableDetails;
  final dynamic tableDetails;

  const PlaceOrderScreen({Key? key, this.tableDetails}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  GetMenuItemsBloc? getMenuItemsBloc;
  PostSalesOrderRepository? _postSalesOrderRepository;

  GetTableListBloc? getTableListBloc;

  @override
  void initState() {
    getMenuItemsBloc = BlocProvider.of<GetMenuItemsBloc>(context);
    getTableListBloc = BlocProvider.of<GetTableListBloc>(context);

    _postSalesOrderRepository = PostSalesOrderRepository();
    super.initState();
  }

  final TextEditingController _searchTextEditingController =
      TextEditingController();
  final List<SelectedItemsListDatum>? selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text("Select Order for ${widget.tableDetails.table}"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchTextEditingController,
              decoration: InputDecoration(
                hintText: "Item Name",
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(248.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              onChanged: (value) {
                getMenuItemsBloc!.add(FetchMenuItems(
                    searchItemName: _searchTextEditingController.text));
              },
            ),
            UIHelper.verticalSpaceSmall(context),
            Text(
              "Select order items",
              style: Theme.of(context).textTheme.headline6,
            ),
            UIHelper.verticalSpaceSmall(context),
            Expanded(
                child: BlocBuilder<GetMenuItemsBloc, GetMenuItemsState>(
              bloc: getMenuItemsBloc,
              builder: (context, state) {
                if (state is GetMenuItemsInitialState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetMenuItemsLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetMenuItemsLoadedState) {
                  return GridView.builder(
                    addAutomaticKeepAlives: true,
                    cacheExtent: 100.0,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: state.itemsList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) => GridItem(
                      index: index,
                      items: state.itemsList!,
                      isSelected: (bool value, String remarks, String qty) {
                        setState(() {
                          if (value) {
                            selectedList!.add(
                              SelectedItemsListDatum(
                                  itemCode: state.itemsList![index].itemCode,
                                  itemName: state.itemsList![index].itemName,
                                  unitCode: state.itemsList![index].unitCode,
                                  salesRate: state.itemsList![index].salesRate,
                                  itemImage: state.itemsList![index].itemImage,
                                  remarks: remarks,
                                  qty: qty,
                                  tableCode: widget.tableDetails.tableCode),
                            );
                          } else {
                            selectedList!.remove(
                              SelectedItemsListDatum(
                                itemCode: state.itemsList![index].itemCode,
                                itemName: state.itemsList![index].itemName,
                                unitCode: state.itemsList![index].unitCode,
                                salesRate: state.itemsList![index].salesRate,
                                itemImage: state.itemsList![index].itemImage,
                                remarks: remarks,
                                qty: qty,
                                tableCode: widget.tableDetails.tableCode,
                              ),
                            );
                          }
                        });
                        debugPrint(selectedList.toString());
                      },
                      key: Key(index.toString()),
                    ),
                  );
                }
                if (state is GetMenuItemsLoadingErrorState) {
                  return const Center(
                    child: Text("Could not load the list of menu items"),
                  );
                }

                return const Center(
                  child: Text("Something went wrong"),
                );
              },
            )),
            UIHelper.verticalSpaceSmall(context),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedList!.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AddOneItemDialogBuilder());
                      } else {
                        try {
                          DialogUtils.showLoadingDialog(context);
                          PostResponseModel postResponse =
                              await _postSalesOrderRepository!
                                  .postSalesOrderList(
                            salesOrders: selectedList!,
                            paymentRemarks: "Payment Remarks",
                          );

                          //failed to post sales order
                          if (postResponse.success == 0) {
                            Navigator.of(context, rootNavigator: true).pop();
                            SnackBarUtils.displaySnackBar(
                                color: Colors.red,
                                context: context,
                                message: "Could not place order");
                          }
                          //success while posting sales order
                          else {
                            SnackBarUtils.displaySnackBar(
                                color: Colors.green,
                                context: context,
                                message: "Order placed");
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);

                            getTableListBloc!.add(FetchTableListEvent());
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                          SnackBarUtils.displaySnackBar(
                              color: Colors.red,
                              context: context,
                              message: "Something went wrong");
                        }
                      }
                    },
                    child: const Text("SUBMIT"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatefulWidget {
  final List<ItemsListDatum>? items;
  final int? index;
  final Function(bool value, String remarks, String qty)? isSelected;

  const GridItem({Key? key, this.isSelected, this.index, this.items})
      : super(key: key);

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem>
    with AutomaticKeepAliveClientMixin {
  bool isSelected = false;
  String remarks = "";
  TextEditingController remarksEditingController = TextEditingController();
  TextEditingController qtyEditingController = TextEditingController(text: '1');

  @override
  void dispose() {
    remarksEditingController.dispose();
    qtyEditingController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });

        if (isSelected) {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //remarks
                            Text("Enter item remarks"),
                            UIHelper.verticalSpace(5),
                            TextField(
                              controller: remarksEditingController,
                              maxLines: 5,
                              decoration: inputDecoration(context),
                            ),
                            UIHelper.verticalSpaceSmall(context),
                            //quantity
                            Text("Enter item quantity"),
                            UIHelper.verticalSpace(5),
                            TextField(
                              controller: qtyEditingController,
                              decoration: inputDecoration(context),
                            ),
                            UIHelper.verticalSpaceSmall(context),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      remarks = remarksEditingController.text;
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      FocusScope.of(context).unfocus();

                                      widget.isSelected!(
                                        isSelected,
                                        remarks,
                                        qtyEditingController.text,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: const Text("Add Remarks"),
                                    ),
                                  ),
                                ),
                                UIHelper.horizontalSpaceSmall(context),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
        }
      },
      child: Stack(
        children: <Widget>[
          Card(
            color: isSelected ? Colors.black12 : Colors.white,
            elevation: 5,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/1.jpg"), fit: BoxFit.fill),
              ),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.green.withOpacity(isSelected ? 0.4 : 0),
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        // color: Colors.black45,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topRight,
                          colors: [
                            Colors.black87,
                            Colors.black54,
                            Colors.black45
                          ],
                        )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.items![widget.index!].itemName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              "Rs. ${widget.items![widget.index!].salesRate!}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          isSelected
              ? const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  InputDecoration inputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class AddOneItemDialogBuilder extends StatelessWidget {
  const AddOneItemDialogBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add at least one item."),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text("OK"))
      ],
    );
  }
}
