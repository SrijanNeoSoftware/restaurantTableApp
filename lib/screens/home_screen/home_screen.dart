import 'package:flutter/material.dart';
import 'package:restaurant_table_app/screens/menu_screen/menu_screen.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleAvatar(
          radius: 5.0,
          child: Icon(Icons.person),
        ),
        title: const Text("Srijan Maharjan"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a table",
                style: Theme.of(context).textTheme.headline6,
              ),
              UIHelper.verticalSpaceSmall(context),
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    debugPrint("Table ${index + 1}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuScreen(
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Table",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            "${index + 1}",
                            style: Theme.of(context).textTheme.headline3,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
