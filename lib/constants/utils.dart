import 'package:flutter/material.dart';

class Utils {
  BuildContext? context;
  Utils(this.context);
  
  double get screenHeight => MediaQuery.of(context!).size.height;
  double get screenWidth => MediaQuery.of(context!).size.width;
}
