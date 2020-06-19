import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../modal.dart';
import '../dio.dart';
import 'dart:convert';

class Statistical extends StatefulWidget {

  @override
  _StatisticalState createState() => _StatisticalState();
}

class _StatisticalState extends State<Statistical> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setHeight(400),
      decoration: BoxDecoration(
          color: Color.fromRGBO(243, 245, 247, 1),
          image: DecorationImage(
            image: AssetImage('images/statisticalBg.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          )
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            width: ScreenUtil().setWidth(346),
            bottom: 10.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
              ),
              child: Column(
                children: <Widget>[
                  title(),
                  listItem(
                      _statisticalModal.signStatistics.ktvCount,
                      _statisticalModal.signStatistics.roomCount,
                      _statisticalModal.signStatistics.lastWeekKtvGrow,
                      "场所签约情况"
                  ),
                  listItem(
                      _statisticalModal.implementStatistics.ktvCount,
                      _statisticalModal.implementStatistics.roomCount,
                      _statisticalModal.implementStatistics.lastWeekKtvGrow,
                      "场所接入情况"
                  ),
                  listItem(
                      _statisticalModal.scanStatistics.ktvCount,
                      _statisticalModal.scanStatistics.roomCount,
                      _statisticalModal.scanStatistics.lastWeekKtvGrow,
                      "扫码计费情况"
                  ),
                  listItem(
                      _statisticalModal.cdnStatistics.ktvCount,
                      _statisticalModal.cdnStatistics.roomCount,
                      _statisticalModal.cdnStatistics.lastWeekKtvGrow,
                      "曲库管理开通情况"
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget title(){
    return Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('场所概括', style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromRGBO(183, 183, 183, 1),
                  fontWeight: FontWeight.w400
              ),),
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('包厢数', style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromRGBO(183, 183, 183, 1),
                  fontWeight: FontWeight.w400
              ),),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('场所概括', style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromRGBO(183, 183, 183, 1),
                  fontWeight: FontWeight.w400
              ),),
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem(int ktv, int room, int grow, String title){
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      height: 64.0,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(221, 221, 221, 0.31),
                offset: Offset(0, 2),
                spreadRadius: 2.0,
                blurRadius: 10.0
            )
          ],
          borderRadius: BorderRadius.all(
              Radius.circular(4.0)
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(title, style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(108, 114, 124, 1),
              ),),
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(ktv.toString(), style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),),
                ),
                Positioned(
                  bottom: 10.0,
                  child: Opacity(
                    opacity: grow == 0 ? 0.0:1.0,
                    child: Text('较上周+${grow.toString()}', style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(183, 183, 183, 1),
                        fontSize: 10.0
                    ),),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(room.toString(), style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(68, 68, 68, 1),
              ),),
            ),
          ),
        ],
      ),
    );
  }

  StatisticalModal _statisticalModal;

  @override
  void initState() {
    _statisticalModal = StatisticalModal.init();
    getData();
    super.initState();
  }

  Future getData() async{
    var params = {
      'province': ''
    };
    try{
      Response response = await getStatisticalData(params);
      var data = jsonDecode(response.toString());
      setState(() {
        _statisticalModal = StatisticalModal.fromJson(data);
      });
    } on DioError catch(e){
      print(e.response);
    }
  }

}
