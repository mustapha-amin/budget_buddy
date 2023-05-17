import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VerticalSpacing extends StatelessWidget {
  double? height;
  VerticalSpacing({this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

// ignore: must_be_immutable
class HorizontalSpacing extends StatelessWidget {
  double? width;
  HorizontalSpacing({this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
