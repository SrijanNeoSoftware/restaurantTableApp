import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_table_app/bloc/get_menu_items_bloc/get_menu_items_bloc.dart';
import 'package:restaurant_table_app/bloc/get_order_details_bloc/get_order_details_bloc.dart';
import 'package:restaurant_table_app/bloc/get_table_list_bloc/get_table_list_bloc.dart';
import 'package:restaurant_table_app/constants/ui_constants.dart';
import 'package:restaurant_table_app/models/get_order_details_model.dart';
import 'package:restaurant_table_app/repository/get_menu_items_repository.dart';
import 'package:restaurant_table_app/repository/get_tables_repository.dart';
import 'package:restaurant_table_app/screens/place_order_screen/place_order_screen.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class SelectedItemsScreen extends StatefulWidget {
  final dynamic tableDetails;
  const SelectedItemsScreen({Key? key, required this.tableDetails})
      : super(key: key);

  @override
  State<SelectedItemsScreen> createState() => _SelectedItemsScreenState();
}

class _SelectedItemsScreenState extends State<SelectedItemsScreen> {
  GetOrderDetailsBloc? getOrderDetailsBloc;
  @override
  void initState() {
    getOrderDetailsBloc = BlocProvider.of<GetOrderDetailsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order for ${widget.tableDetails.table}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var data = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => GetMenuItemsBloc(
                              getMenuItemsRepository: GetMenuItemsRepository())
                            ..add(
                              FetchMenuItems(searchItemName: ""),
                            ),
                        ),
                        BlocProvider(
                          create: (context) => GetTableListBloc(
                              getTablesListRepository:
                                  GetTablesListRepository())
                            ..add(
                              FetchTableListEvent(),
                            ),
                        ),
                      ],
                      child: PlaceOrderScreen(
                        tableDetails: widget.tableDetails,
                      ),
                    )),
          );
        },
        child: Image.asset(
          'assets/serving.png',
          height: 40,
          width: 40,
        ),
      ),
      body: BlocBuilder<GetOrderDetailsBloc, GetOrderDetailsState>(
          builder: (BuildContext context, GetOrderDetailsState state) {
        debugPrint(state.toString());
        if (state is GetOrderDetailsInitialState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetOrderDetailsLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetOrderDetailsLoadedState) {
          List<GetOrderDetailsDatum> orderedItems = state.orderDetails.data;

          if (orderedItems.isEmpty) {
            return Center(
              child: Text("Please add an item"),
            );
          } else {
            var totalPrice = orderedItems.fold(0,
                (int previousValue, element) => previousValue + element.amount);
            return Container(
              margin: screenMargin,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //items list
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        getOrderDetailsBloc!.add(FetchOrderDetailsEvent(
                            tableCode: widget.tableDetails!.tableCode));
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderedItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                orderedItems[index].itemName,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rs. " +
                                        orderedItems[index].amount.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    "Quantity: " +
                                        orderedItems[index].quantity.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  UIHelper.verticalSpaceMedium(context),
                  //total price
                  Row(
                    children: [
                      Text(
                        "Rs. " + totalPrice.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        }
        if (state is GetOrderDetailsLoadingErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      }),
    );
  }
}
