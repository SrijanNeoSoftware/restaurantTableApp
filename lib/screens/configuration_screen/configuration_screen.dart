import 'package:flutter/material.dart';
import 'package:restaurant_table_app/constants/ui_constants.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _baseUrlController = TextEditingController();
  TextEditingController _portController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuration Screen"),
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
              UIHelper.verticalSpaceMedium(context),
              Text("Port"),
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
                        debugPrint("BASE URL " + _baseUrlController.text);
                        debugPrint("PORT " + _portController.text);
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
