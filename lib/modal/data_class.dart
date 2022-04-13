import 'package:flutter/material.dart';

class TapData {
  final String title;
  final TapType tapType;
  final TextEditingController? textEditingController;
  TapData(this.title, this.tapType, this.textEditingController);
}

enum TapType { inch, meter, foot, centimeter }
