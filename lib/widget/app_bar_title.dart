import 'package:flutter/material.dart';
import 'package:note_app/constant.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: title1,
          ),
          TextSpan(
            text: subtitle,
            style: title2,
          ),
        ],
      ),
    );
  }
}
