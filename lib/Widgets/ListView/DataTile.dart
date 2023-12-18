import 'package:flutter/material.dart';

import '../../Configuration/ImageConfig.dart';

class DataContain extends StatefulWidget {
  final String title;
  final String stitle;
  final String trail;

  const DataContain(
      {Key key, @required this.title, @required this.stitle, this.trail})
      : super(key: key);

  @override
  State<DataContain> createState() => _DataContainState();
}

class _DataContainState extends State<DataContain> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        trailing: widget.trail != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ImageConfig.fromAsset(imagePath: widget.trail, size: 40),
              )
            : Text(""),
        dense: true,
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        title: Text(widget.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff3B3B3B),
                fontSize: 14)),
        subtitle: Text(
          widget.stitle,
          style: TextStyle(
              color: Color(0xff285678),
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
      ),
    );
  }
}
