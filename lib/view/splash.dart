import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import '../router/navigatorUtil.dart';
import '../libs/util.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);
    return Scaffold(
      body: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(200)),
          color: Theme.of(context).primaryColor,
          alignment: Alignment.topCenter,
          child: Image(
            image: AssetImage('images/logo_text.png'),
            width: ScreenUtil().setWidth(300),
            fit: BoxFit.contain,
          ),
        ),
        onTap: (){
          FocusNode focusNode = new FocusNode();
          FocusScope.of(context).requestFocus(focusNode);
        },
        behavior: HitTestBehavior.translucent,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
     Timer(Duration(seconds: 2), (){
       this.goHomePage();
     });
  }

  void goHomePage() async{
      String token =  await Utils.getToken();
      print(token);
      if(token != '' && token != null){
        NavigatorUtil.goHome(context);
      }else{
        NavigatorUtil.goLogin(context);
      }

  }

}
