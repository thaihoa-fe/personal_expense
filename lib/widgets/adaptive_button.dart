import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String title;
  final Function onPress;

  AdaptiveButton({this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              "Choose date",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark),
            ),
            onPressed: onPress,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColorDark,
            child: Text(
              "Choose date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: onPress,
          );
  }
}
