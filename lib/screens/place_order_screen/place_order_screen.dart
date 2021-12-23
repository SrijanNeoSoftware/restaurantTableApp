import 'package:flutter/material.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class PlaceOrderScreen extends StatelessWidget {
  PlaceOrderScreen({Key? key}) : super(key: key);
  final TextEditingController _searchTextEditingController =
      TextEditingController();
  final List<int> text = List.generate(50, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Order"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchTextEditingController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(248.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpaceSmall(context),
            Text(
              "Select order items",
              style: Theme.of(context).textTheme.headline6,
            ),
            UIHelper.verticalSpaceSmall(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(text.length, (index) {
                    return MenuItemCardBuilder(text: text);
                  }),
                ),
              ),
            ),
            UIHelper.verticalSpaceSmall(context),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("SUBMIT"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MenuItemCardBuilder extends StatelessWidget {
  final int? index;
  final List<int>? text;

  const MenuItemCardBuilder({Key? key, this.index, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 2,
      child: ListTile(
        title: Text("data"),
      ),
    );
  }
}
