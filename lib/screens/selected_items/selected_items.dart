import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_table_app/bloc/get_menu_items_bloc/get_menu_items_bloc.dart';
import 'package:restaurant_table_app/main.dart';
import 'package:restaurant_table_app/models/post_response_model.dart';
import 'package:restaurant_table_app/models/selected_items_list_model.dart';
import 'package:restaurant_table_app/repository/get_menu_items_repository.dart';
import 'package:restaurant_table_app/repository/post_sales_order.dart';
import 'package:restaurant_table_app/screens/place_order_screen/place_order_screen.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class SelectedItemsScreen extends StatefulWidget {
  // final SelectedItemsListDatum tableDetails;

  final dynamic tableDetails;
  const SelectedItemsScreen({Key? key, required this.tableDetails})
      : super(key: key);

  @override
  State<SelectedItemsScreen> createState() => _SelectedItemsScreenState();
}

class _SelectedItemsScreenState extends State<SelectedItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class SelectedItemsScreen extends StatefulWidget {
//   // final SelectedItemsListDatum tableDetails;

//   final dynamic tableDetails;
//   const SelectedItemsScreen({Key? key, required this.tableDetails})
//       : super(key: key);

//   @override
//   State<SelectedItemsScreen> createState() => _SelectedItemsScreenState();
// }

// class _SelectedItemsScreenState extends State<SelectedItemsScreen> {
//   TextEditingController remarksEditingController = TextEditingController();

//   List<SelectedItemsListDatum> previousList = [];
//   List<SelectedItemsListDatum> displayList = [];
//   double? totalAmount = 0.0;
//   @override
//   void initState() {
//     previousList = box.get(widget.tableDetails.table) ?? [];

//     for (var items in previousList) {
//       totalAmount =
//           totalAmount! + (items.salesRate! * int.tryParse(items.qty!)!);
//     }

//     displayList = displayList + previousList;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Order for ${widget.tableDetails.table}"),
//         actions: [
//           displayList.isNotEmpty
//               ? IconButton(
//                   onPressed: () {
//                     setState(() {
//                       totalAmount = 0.0;
//                       previousList.clear();
//                       displayList.clear();
//                     });
//                   },
//                   icon: const Icon(Icons.clear),
//                 )
//               : Container(),
//         ],
//       ),
//       floatingActionButton: displayList.isEmpty
//           ? FloatingActionButton(
//               onPressed: () async {
//                 var data = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BlocProvider(
//                       create: (context) => GetMenuItemsBloc(
//                           getMenuItemsRepository: GetMenuItemsRepository())
//                         ..add(FetchMenuItems(searchItemName: "")),
//                       child: PlaceOrderScreen(
//                         tableDetails: widget.tableDetails,
//                       ),
//                     ),
//                   ),
//                 );
//                 previousList = box.get(widget.tableDetails.table) ?? [];

//                 for (var items in previousList) {
//                   totalAmount = totalAmount! +
//                       (items.salesRate! * int.tryParse(items.qty!)!);
//                 }

//                 displayList = displayList + previousList;
//                 remarksEditingController.clear();
//                 setState(() {});
//               },
//               child: Image.asset(
//                 'assets/serving.png',
//                 height: 40,
//                 width: 40,
//               ),
//             )
//           : Container(),
//       body: Container(
//         margin: const EdgeInsets.all(20),
//         child: displayList.isEmpty
//             ? Center(
//                 child: Text("Please add an item"),
//               )
//             : Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: displayList.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                             child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     displayList[index].itemName!,
//                                     style:
//                                         Theme.of(context).textTheme.headline6,
//                                   ),
//                                   Text(
//                                     "Rs. ${displayList[index].salesRate! * int.tryParse(displayList[index].qty!)!}",
//                                     style:
//                                         Theme.of(context).textTheme.headline6,
//                                   ),
//                                 ],
//                               ),
//                               Text("Quantity: " + displayList[index].qty!),
//                               Text("Remarks: " + displayList[index].remarks!),
//                             ],
//                           ),
//                         ));
//                       },
//                     ),
//                   ),
//                   totalAmount != 0.0
//                       ? Row(
//                           children: [
//                             Text(
//                               "Rs. $totalAmount",
//                               style: Theme.of(context).textTheme.headline3,
//                             ),
//                           ],
//                         )
//                       : Container(),
//                   UIHelper.verticalSpaceSmall(context),
//                   displayList.isEmpty
//                       ? Container()
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             UIHelper.horizontalSpaceSmall(context),
//                             Expanded(
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Colors.green),
//                                 onPressed: () {
//                                   // setState(() {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) => Dialog(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: SingleChildScrollView(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               //remarks
//                                               Text("Enter payment remarks"),
//                                               UIHelper.verticalSpace(5),
//                                               TextField(
//                                                 controller:
//                                                     remarksEditingController,
//                                                 maxLines: 5,
//                                                 decoration:
//                                                     inputDecoration(context),
//                                               ),
//                                               UIHelper.verticalSpaceSmall(
//                                                   context),

//                                               UIHelper.verticalSpaceSmall(
//                                                   context),
//                                               Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: ElevatedButton(
//                                                       onPressed: () async {
//                                                         try {
//                                                           PostResponseModel
//                                                               postResponse =
//                                                               await PostSalesOrderRepository().postSalesOrderList(
//                                                                   salesOrders:
//                                                                       displayList,
//                                                                   paymentRemarks:
//                                                                       remarksEditingController
//                                                                           .text);

//                                                           if (postResponse
//                                                                   .success ==
//                                                               1) {
//                                                             box.delete(widget
//                                                                 .tableDetails
//                                                                 .table);
//                                                             previousList
//                                                                 .clear();
//                                                             displayList.clear();
//                                                             totalAmount = 0.0;
//                                                             Navigator.of(
//                                                                     context,
//                                                                     rootNavigator:
//                                                                         true)
//                                                                 .pop();
//                                                             setState(() {});
//                                                             ScaffoldMessenger
//                                                                     .of(context)
//                                                                 .showSnackBar(SnackBar(
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .green,
//                                                                     content: Text(
//                                                                         postResponse
//                                                                             .message)));
//                                                           } else {
//                                                             Navigator.of(
//                                                                     context,
//                                                                     rootNavigator:
//                                                                         true)
//                                                                 .pop();

//                                                             ScaffoldMessenger
//                                                                     .of(context)
//                                                                 .showSnackBar(SnackBar(
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .red,
//                                                                     content: Text(
//                                                                         postResponse
//                                                                             .message)));
//                                                           }
//                                                         } catch (e) {
//                                                           Navigator.of(context,
//                                                                   rootNavigator:
//                                                                       true)
//                                                               .pop();

//                                                           ScaffoldMessenger.of(
//                                                                   context)
//                                                               .showSnackBar(SnackBar(
//                                                                   backgroundColor:
//                                                                       Colors
//                                                                           .red,
//                                                                   content: Text(
//                                                                       'Bill payment failed')));
//                                                         }
//                                                       },
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(16.0),
//                                                         child: const Text(
//                                                             "Add Remarks"),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   UIHelper.horizontalSpaceSmall(
//                                                       context),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(24.0),
//                                   child: const Text("PAY BILL"),
//                                 ),
//                               ),
//                             ),
//                             UIHelper.horizontalSpaceSmall(context),
//                             Expanded(
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Colors.blue),
//                                 onPressed: () async {
//                                   var data = await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => BlocProvider(
//                                         create: (context) => GetMenuItemsBloc(
//                                             getMenuItemsRepository:
//                                                 GetMenuItemsRepository())
//                                           ..add(FetchMenuItems(
//                                               searchItemName: "")),
//                                         child: PlaceOrderScreen(
//                                           tableDetails: widget.tableDetails,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                   previousList =
//                                       box.get(widget.tableDetails.table) ?? [];

//                                   totalAmount = 0.0;

//                                   for (var items in previousList) {
//                                     totalAmount = totalAmount! +
//                                         (items.salesRate! *
//                                                 int.tryParse(items.qty!)!)
//                                             .toDouble();
//                                   }

//                                   displayList = previousList;
//                                   remarksEditingController.clear();
//                                   setState(() {});
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(24.0),
//                                   child: const Text("ADD ITEM"),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                 ],
//               ),
//       ),
//     );
//   }

//   InputDecoration inputDecoration(BuildContext context) {
//     return InputDecoration(
//       contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//       border: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//     );
//   }
// }

// class PaymentRemarksDialogBuilder extends StatefulWidget {
//   const PaymentRemarksDialogBuilder({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<PaymentRemarksDialogBuilder> createState() =>
//       _PaymentRemarksDialogBuilderState();
// }

// class _PaymentRemarksDialogBuilderState
//     extends State<PaymentRemarksDialogBuilder> {
//   TextEditingController remarksEditingController = TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //remarks
//               Text("Enter payment remarks"),
//               UIHelper.verticalSpace(5),
//               TextField(
//                 controller: remarksEditingController,
//                 maxLines: 5,
//                 decoration: inputDecoration(context),
//               ),
//               UIHelper.verticalSpaceSmall(context),

//               UIHelper.verticalSpaceSmall(context),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: const Text("Add Remarks"),
//                       ),
//                     ),
//                   ),
//                   UIHelper.horizontalSpaceSmall(context),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   InputDecoration inputDecoration(BuildContext context) {
//     return InputDecoration(
//       contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//       border: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Theme.of(context).primaryColor,
//         ),
//       ),
//     );
//   }
// }
