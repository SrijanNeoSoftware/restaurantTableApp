import 'package:flutter/material.dart';
import 'package:restaurant_table_app/main.dart';
import 'package:restaurant_table_app/screens/configuration_screen/configuration_screen.dart';
import 'package:restaurant_table_app/utils/snackbar_utils.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Set Application Configurations",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConfigurationScreen(),
            ),
          );
        },
        child: const Icon(Icons.settings, color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/bg.jpg',
                ),
                fit: BoxFit.fitHeight)),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpaceMedium(context),
                    Text(
                      "LOGIN",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(letterSpacing: 6, color: Colors.grey),
                    ),
                    UIHelper.verticalSpaceSmall(context),
                    TextFormField(
                      controller: _usernameEditingController,
                      style: const TextStyle(color: Colors.grey),
                      decoration: const InputDecoration(
                        label: Text(
                          "Username",
                          style: TextStyle(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return "Username is required";
                        }
                      },
                    ),
                    UIHelper.verticalSpaceSmall(context),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordEditingController,
                      style: const TextStyle(color: Colors.grey),
                      decoration: const InputDecoration(
                        label: Text(
                          "Password",
                          style: TextStyle(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return "Password is required";
                        }
                      },
                    ),
                    UIHelper.verticalSpaceMedium(context),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor),
                            onPressed: () {
                              String baseUrl = box.get("baseUrl") ?? "";
                              String port = box.get("port") ?? "";
                              if (_formKey.currentState!.validate()) {
                                if (baseUrl.isEmpty || port.isEmpty) {
                                  SnackBarUtils.displaySnackBar(
                                      context: context,
                                      color: Colors.red,
                                      message: "No configurations found!");
                                } else if (_usernameEditingController.text
                                            .trim() ==
                                        "admin" &&
                                    _passwordEditingController.text.trim() ==
                                        "admin") {
                                  Navigator.pushReplacementNamed(
                                      context, 'homeScreen');
                                } else {
                                  SnackBarUtils.displaySnackBar(
                                      context: context,
                                      color: Colors.red,
                                      message: "Invalid username or password!");
                                }
                              }
                            },
                            child: const Text("LOGIN"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
