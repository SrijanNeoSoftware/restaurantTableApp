import 'package:flutter/material.dart';
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
                              if (_formKey.currentState!.validate()) {
                                if (_usernameEditingController.text ==
                                        "admin" &&
                                    _passwordEditingController.text ==
                                        "admin") {
                                  Navigator.pushReplacementNamed(
                                      context, 'homeScreen');
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "Invalid username or password")),
                                  );
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
