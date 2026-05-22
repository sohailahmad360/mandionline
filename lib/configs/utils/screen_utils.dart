import 'package:flutter/material.dart';

/// Responsive scaling helpers (extend with design-width baseline from Figma).
class ScreenUtils {
  ScreenUtils._();

  static double width(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static EdgeInsets padding(BuildContext context) =>
      MediaQuery.paddingOf(context);
}
