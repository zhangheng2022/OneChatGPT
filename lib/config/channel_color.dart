import 'package:flutter/material.dart';

class ChannelColor {
  static final Map<String, Color> colorMap = {
    "green": Colors.green,
    "black": Colors.black,
    "olive": Colors.deepOrange,
    "orange": Colors.orange,
    "blue": Colors.blue,
    "violet": Colors.deepPurple,
    "teal": Colors.teal,
    "red": Colors.red,
    "pink": Colors.pink,
    "purple": Colors.purple,
    "brown": Colors.brown,
  };

  static Color getColorFromName(String colorName) {
    final color = colorMap[colorName];
    return color ?? Colors.black; // 使用默认颜色
  }
}
