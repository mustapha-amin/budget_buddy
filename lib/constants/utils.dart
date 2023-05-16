import 'package:flutter/material.dart';

class Utils {
  BuildContext? context;
  Size get screenSize => MediaQuery.of(context!).size;
}
