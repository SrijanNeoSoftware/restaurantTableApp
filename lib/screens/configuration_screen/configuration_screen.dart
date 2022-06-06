import 'package:flutter/material.dart';
import 'package:restaurant_table_app/constants/ui_constants.dart';
import 'package:restaurant_table_app/main.dart';
import 'package:restaurant_table_app/utils/snackbar_utils.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _baseUrlController =
      TextEditingController(text: box.get("baseUrl") ?? "");
  TextEditingController _portController =
      TextEditingController(text: box.get("port") ?? "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuration Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _baseUrlController.clear();
            _portController.clear();
            box.clear();
            SnackBarUtils.displaySnackBar(
              context: context,
              color: Colors.green,
              message: "Configurations removed",
            );
          });
        },
        child: Icon(Icons.clear),
      ),
      body: Container(
        margin: screenMargin,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Base URL"),
              UIHelper.verticalSpace(5),
              TextFormFieldBuilder(
                controller: _baseUrlController,
              ),
              UIHelper.verticalSpace(3),
              Text(
                "Hint: 100.01.012.101",
                style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
              ),
              UIHelper.verticalSpaceMedium(context),
              Text("Port"),
              UIHelper.verticalSpace(3),
              Text(
                "Hint: 1234",
                style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
              ),
              UIHelper.verticalSpace(5),
              TextFormFieldBuilder(
                controller: _portController,
              ),
              UIHelper.verticalSpaceMedium(context),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          debugPrint("BASE URL " + _baseUrlController.text);
                          debugPrint("PORT " + _portController.text);

                          try {
                            box.put("baseUrl", _baseUrlController.text.trim());
                            box.put("port", _portController.text.trim());
                            SnackBarUtils.displaySnackBar(
                              context: context,
                              color: Colors.green,
                              message: "Configurations set",
                            );
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          } catch (e) {
                            SnackBarUtils.displaySnackBar(
                              context: context,
                              color: Colors.red,
                              message: "Failed to set configurations",
                            );
                          }
                        }
                      },
                      child: Text(
                        "SET CONFIGURATIONS",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFormFieldBuilder extends StatelessWidget {
  final TextEditingController? controller;
  const TextFormFieldBuilder({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
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
      ),
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return "*Required";
        }
      },
    );
  }
}
