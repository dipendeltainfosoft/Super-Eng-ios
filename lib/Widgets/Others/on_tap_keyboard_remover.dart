import 'package:flutter/material.dart';

class OnTapKeyBoardRemoveWidget extends StatelessWidget {
  const OnTapKeyBoardRemoveWidget({this.child});
  final Widget child;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Material(child: child),
    );
  }
}
