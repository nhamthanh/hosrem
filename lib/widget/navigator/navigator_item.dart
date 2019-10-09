import 'package:flutter/material.dart';

/// Navigator Item.
@immutable
class NavigatorItem extends StatelessWidget {
  const NavigatorItem({this.text, this.icon, this.onTap});

  final String text;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(children: <Widget>[
        icon == null ? const Text('') : Icon(icon),
        const SizedBox(width: 10.0),
        Expanded(child: Text(text)),
        IconButton(
          icon: Icon(Icons.keyboard_arrow_right),
          onPressed: () {},
        ),
      ]),
      onTap: onTap
    );
  }
}
