import 'package:flutter/material.dart';
import 'package:restaurant_table_app/constants/ui_constants.dart';
import 'package:restaurant_table_app/models/get_order_details_model.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class EditOrderDialogBuilder extends StatefulWidget {
  final GetOrderDetailsDatum orderItem;

  const EditOrderDialogBuilder({Key? key, required this.orderItem})
      : super(key: key);

  @override
  State<EditOrderDialogBuilder> createState() => _EditOrderDialogBuilderState();
}

class _EditOrderDialogBuilderState extends State<EditOrderDialogBuilder> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  double? salesRate;
  double? totalAmount;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    salesRate = widget.orderItem.amount / widget.orderItem.quantity;
    quantityController.text = widget.orderItem.quantity.toString();
    totalAmount = widget.orderItem.quantity * salesRate!;
    amountController.text = totalAmount!.toString();
    super.initState();
  }

  @override
  void dispose() {
    quantityController.dispose();
    amountController.dispose();
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
                      amountController.clear();
                    });
                  } else {
                    setState(() {
                      amountController.text =
                          (int.tryParse(value)! * salesRate!).toString();
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
              TextFormField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: inputBorderDecoration(
                    context: context, label: "Amount (Rs.)"),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "*";
                  }
                },
              ),
              UIHelper.verticalSpaceSmall(context),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          debugPrint(quantityController.text);
                          debugPrint(amountController.text);
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
