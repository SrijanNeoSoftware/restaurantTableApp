import 'package:flutter/material.dart';
import 'package:restaurant_table_app/screens/home_screen/home_screen.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  const Icon(
                    Icons.restaurant,
                    size: 124,
                  ),
                  UIHelper.verticalSpaceMedium(context),
                  Text(
                    "LOGIN",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(letterSpacing: 6),
                  ),
                  UIHelper.verticalSpaceSmall(context),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Username"),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  UIHelper.verticalSpaceSmall(context),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                  ),
                  UIHelper.verticalSpaceMedium(context),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
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
    );
  }
}
