import 'package:flutter/material.dart';
import 'package:mylis/theme/color.dart';

Color changeStringToColor(String color) {
  switch (color) {
    case "black":
      return Colors.black;
    case "red":
      return ThemeColor.red;
    case "orange":
      return ThemeColor.orange;
    case "pastelOrange":
      return ThemeColor.pastelOrange;
    case "pink":
      return ThemeColor.pink;
    case "pastelPink":
      return ThemeColor.pastelPink;

    case "blue":
      return ThemeColor.blue;
    case "pastelBlue":
      return ThemeColor.pastelBlue;
    case "yellow":
      return ThemeColor.yellow;
    case "green":
      return ThemeColor.green;
    case "pastelGreen":
      return ThemeColor.pastelGreen;
    case "pastelPurple":
      return ThemeColor.pastelPurple;
    default:
      return Colors.white;
  }
}

String changeColorToString(Color color) {
  if (color == Colors.black) {
    return "black";
  } else if (color == ThemeColor.red) {
    return "red";
  } else if (color == ThemeColor.orange) {
    return "orange";
  } else if (color == ThemeColor.pastelOrange) {
    return "pastelOrange";
  } else if (color == ThemeColor.pink) {
    return "pink";
  } else if (color == ThemeColor.pastelPink) {
    return "pastelPink";
  } else if (color == ThemeColor.blue) {
    return "blue";
  } else if (color == ThemeColor.pastelBlue) {
    return "pastelBlue";
  } else if (color == ThemeColor.yellow) {
    return "yellow";
  } else if (color == ThemeColor.green) {
    return "green";
  } else if (color == ThemeColor.pastelGreen) {
    return "pastelGreen";
  } else if (color == ThemeColor.pastelPurple) {
    return "pastelPurple";
  } else {
    return "white";
  }
}
