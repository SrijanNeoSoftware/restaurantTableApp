import 'package:flutter/material.dart';
import 'package:restaurant_table_app/bloc/get_order_details_bloc/get_order_details_bloc.dart';
import 'package:restaurant_table_app/constants/ui_constants.dart';
import 'package:restaurant_table_app/models/get_order_details_model.dart';
import 'package:restaurant_table_app/models/post_response_model.dart';
import 'package:restaurant_table_app/repository/post_edit_order_repository.dart';
import 'package:restaurant_table_app/utils/dialog_utils.dart';
import 'package:restaurant_table_app/utils/snackbar_utils.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class EditOrderDialogBuilder extends StatefulWidget {
  final GetOrderDetailsDatum orderItem;
  final GetOrderDetailsBloc getOrderDetailsBloc;
  final dynamic tableCode;

  const EditOrderDialogBuilder(
      {Key? key,
      required this.orderItem,
      required this.getOrderDetailsBloc,
      required this.tableCode})
      : super(key: key);

  @override
  State<EditOrderDialogBuilder> createState() => _EditOrderDialogBuilderState();
}

class _EditOrderDialogBuilderState extends State<EditOrderDialogBuilder> {
  TextEditingController quantityController = TextEditingController();
  double? salesRate;
  double? totalAmount;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PostUpdateOrderRepository _postUpdateOrderRepository =
      PostUpdateOrderRepository();

  @override
  void initState() {
    salesRate = double.tryParse(
        (widget.orderItem.amount / widget.orderItem.quantity)
            .toStringAsExponential(2));
    quantityController.text = widget.orderItem.quantity.toString();
    totalAmount = double.tryParse(
        (widget.orderItem.quantity * salesRate!).toStringAsExponential(2));
    super.initState();
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: screenMargin,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.orderItem.itemName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    "Rs. $salesRate",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              UIHelper.verticalSpaceSmall(context),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: quantityController,
                decoration:
                    inputBorderDecoration(context: context, label: "Quantity"),
                onChanged: (String value) {
                  if (value.isEmpty) {
                    setState(() {
                      totalAmount = 0.0;
                    });
                  } else {
                    setState(() {
                      totalAmount = double.tryParse(
                          (int.tryParse(value)! * salesRate!)
                              .toStringAsExponential(2));
                    });
                  }
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "*";
                  }
                },
              ),
              UIHelper.verticalSpaceSmall(context),
              Text(
                "Rs. " + totalAmount.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
              UIHelper.verticalSpaceSmall(context),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          debugPrint(widget.orderItem.itemName);
                          debugPrint(int.tryParse(quantityController.text)!
                              .toString());
                          debugPrint(totalAmount.toString());
                          debugPrint(widget.orderItem.transactionNo);
                          debugPrint(widget.orderItem.serialNo.toString());
                          //pop edit dialog
                          Navigator.of(context, rootNavigator: true).pop();
                          DialogUtils.showLoadingDialog(context);
                          PostResponseModel response =
                              await _postUpdateOrderRepository.postUpdateOrder(
                            itemName: widget.orderItem.itemName,
                            quantity: int.tryParse(quantityController.text)!,
                            amount: totalAmount!,
                            transactionNo: widget.orderItem.transactionNo,
                            serialNo: widget.orderItem.serialNo,
                          );

                          if (response.success != 1) {
                            //pop loading dialog
                            Navigator.of(context, rootNavigator: true).pop();
                            SnackBarUtils.displaySnackBar(
                                color: Colors.red,
                                context: context,
                                message: "Order could not be updated!");
                          } else {
                            //pop loading dialog
                            Navigator.of(context, rootNavigator: true).pop();
                            widget.getOrderDetailsBloc.add(
                                FetchOrderDetailsEvent(
                                    tableCode: widget.tableCode));
                            SnackBarUtils.displaySnackBar(
                                color: Colors.green,
                                context: context,
                                message: "Order updated successfully!");
                          }
                        }
                      },
                      child: Text(
                        "Update Order",
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

inputBorderDecoration({required BuildContext context, required String label}) {
  return InputDecoration(
    label: Text(label),
    contentPadding: EdgeInsets.symmetric(horizontal: 8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
      ),
    ),
  );
}
