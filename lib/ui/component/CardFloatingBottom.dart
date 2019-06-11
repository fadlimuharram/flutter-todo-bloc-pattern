import 'package:flutter/material.dart';

class CardFloatingBottom extends StatelessWidget {
  CardFloatingBottom({this.icon, this.onPressed, this.color});

  Icon icon;
  Function onPressed;
  Color color;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5.0,
      onPressed: this.onPressed,
      backgroundColor: this.color,
      child: this.icon,
    );
  }
}
