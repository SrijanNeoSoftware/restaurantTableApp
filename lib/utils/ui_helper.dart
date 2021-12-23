import 'package:flutter/material.dart';

/// Contains useful functions to reduce boilerplate code
class UIHelper {
// 2% of the screen height
  static Widget verticalSpaceSmall(BuildContext context) {
    return verticalSpace(
        MediaQuery.of(context).size.height * 0.02); // 2% of the screen height
  }

  // 5% of the screen height
  static Widget verticalSpaceMedium(BuildContext context) {
    return verticalSpace(MediaQuery.of(context).size.height * 0.05);
  }

  // 10% of the screen height
  static Widget verticalSpaceLarge(BuildContext context) {
    return verticalSpace(MediaQuery.of(context).size.height * 0.10);
  }

  /// Returns a vertical space equal to the [height] supplied
  static Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }

  // 2% of the screen width
  static Widget horizontalSpaceSmall(BuildContext context) {
    return horizontalSpace(MediaQuery.of(context).size.width * 0.02);
  }

// 5% of the screen width
  static Widget horizontalSpaceMedium(BuildContext context) {
    return horizontalSpace(MediaQuery.of(context).size.width * 0.05);
  }

// 10% of the screen width
  static Widget horizontalSpaceLarge(BuildContext context) {
    return horizontalSpace(MediaQuery.of(context).size.width * 0.10);
  }

  /// Returns a vertical space equal to the [width] supplied
  static Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }
}
