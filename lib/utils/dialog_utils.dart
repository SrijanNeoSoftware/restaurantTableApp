import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui_helper.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context,
      {message = "Loading please wait"}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    const CircularProgressIndicator(),
                    UIHelper.horizontalSpaceMedium(context),
                    Text(message, style: Theme.of(context).textTheme.bodyText1)
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.exit_to_app),
            UIHelper.horizontalSpaceSmall(context),
            const Expanded(
              child: Text("Are you sure you want to exit?"),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text("No"),
          ),
        ],
      ),
    );
  }
}
