import 'package:flutter/material.dart';
import 'package:init_flutter/enum/bot_nav_enum.dart';

class BotNavModel {
  final String label;
  final IconData iconData;
  final Widget body;

  BotNavModel({
    required this.label,
    required this.iconData,
    required this.body,
  });
}
