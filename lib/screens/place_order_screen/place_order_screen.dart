import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_table_app/bloc/get_menu_items_bloc/get_menu_items_bloc.dart';
import 'package:restaurant_table_app/models/get_items_list_model.dart';
import 'package:restaurant_table_app/models/selected_items_list_model.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  GetMenuItemsBloc? getMenuItemsBloc;

  @override
  void initState() {
    getMenuItemsBloc = BlocProvider.of<GetMenuItemsBloc>(context);

    super.initState();
  }

  final TextEditingController _searchTextEditingController =
      TextEditingController();
  final List<SelectedItemsListDatum>? selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Order"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchTextEditingController,
              decoration: InputDecoration(
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
                    itemCount: state.itemsList!.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) => GridItem(
                      index: index,
                      items: state.itemsList!.data!,
                      isSelected: (bool value, String remarks) {
                        setState(() {
                          if (value) {
                            selectedList!.add(
                              SelectedItemsListDatum(
                                itemCode:
                                    state.itemsList!.data![index].itemCode,
                                itemName:
                                    state.itemsList!.data![index].itemName,
                                unitCode:
                                    state.itemsList!.data![index].unitCode,
                                salesRate:
                                    state.itemsList!.data![index].salesRate,
                                itemImage:
                                    state.itemsList!.data![index].itemImage,
                                remarks: remarks,
                              ),
                            );
                          } else {
                            selectedList!.remove(
                              SelectedItemsListDatum(
                                itemCode:
                                    state.itemsList!.data![index].itemCode,
                                itemName:
                                    state.itemsList!.data![index].itemName,
                                unitCode:
                                    state.itemsList!.data![index].unitCode,
                                salesRate:
                                    state.itemsList!.data![index].salesRate,
                                itemImage:
                                    state.itemsList!.data![index].itemImage,
                                remarks: remarks,
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
                  print(state.errorMessage);
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
                    onPressed: () {
                      debugPrint(selectedList![0].remarks);
                      Navigator.pop(context, selectedList);
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
  final Function(bool value, String remarks)? isSelected;

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
                          children: [
                            TextField(
                              controller: remarksEditingController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "Enter item name",
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                              ),
                            ),
                            UIHelper.verticalSpaceMedium(context),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      remarks = remarksEditingController.text;
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      widget.isSelected!(isSelected, remarks);
                                    },
                                    child: const Text("Add Remarks"),
                                  ),
                                ),
                                UIHelper.horizontalSpaceSmall(context),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                ),
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
                        color: Colors.black45,
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
}
