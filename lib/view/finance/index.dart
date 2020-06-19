import 'package:flutter/material.dart';
import '../../widget/appBar.dart';
import './components/statistical.dart';
import './components/circular.dart';
import './components/map.dart';

class Finance extends StatefulWidget {
  @override
  _FinanceState createState() => _FinanceState();
}

class _FinanceState extends State<Finance> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        appBar: appTitle(
            title: '联娱大数据',
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Statistical(),
                Circular(),
                Map(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
