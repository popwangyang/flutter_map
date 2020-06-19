import 'package:flutter/material.dart';

class ContentUnFocus extends StatelessWidget {

  final Widget child;

  ContentUnFocus({Key key, this.child}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
    );
  }
}
