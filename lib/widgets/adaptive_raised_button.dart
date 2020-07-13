import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveRaisedButton({this.text, this.handler});

  @override
  Widget build(BuildContext context) {
    final mainTheme = Theme.of(context);

    return Platform.isIOS
        ? CupertinoButton(
            color: mainTheme.primaryColor,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: handler,
          )
        : RaisedButton(
            color: mainTheme.primaryColor,
            textColor: Colors.white,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: handler,
          );
  }
}
