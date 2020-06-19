import 'package:flutter/material.dart';

class KtvPage extends StatefulWidget {
  @override
  _KtvPageState createState() => _KtvPageState();
}

class _KtvPageState extends State<KtvPage> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ktv"),
        ),
        body: Container(
          child: Text("KTV"),
        ),
      ),
    );
  }
}
