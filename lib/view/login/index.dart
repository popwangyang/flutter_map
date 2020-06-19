import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../libs/util.dart';
import '../../widget/input.dart';
import '../../widget/button.dart';
import '../../widget/loading.dart';
import '../../widget/toast.dart';
import '../../widget/content.dart';
import '../../view/login/forgetPassword.dart';
import '../../router/navigatorUtil.dart';
import './dio.dart';
import './modal.dart';

const USERPLACHDER = '请输入邮箱号/手机号/ID';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ContentUnFocus(
      child: Container(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Container(
              width: ScreenUtil().setWidth(375),
              height: ScreenUtil().setHeight(667),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: ScreenUtil().setWidth(375),
                      height: ScreenUtil().setHeight(440),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/BitmapTop.png'),
                              fit: BoxFit.cover
                          )
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
                        child: Image(
                          image: AssetImage('images/logo_text.png'),
                          width: ScreenUtil().setWidth(146),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: ScreenUtil().setWidth(375),
                      height: ScreenUtil().setHeight(57),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:  AssetImage('images/BitmapBottom.png'),
                              fit: BoxFit.fitWidth
                          )
                      ),

                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Container(
                      width: ScreenUtil().setWidth(322),
                      height: ScreenUtil().setHeight(330),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                offset: Offset(0, 3),
                                blurRadius: 7,
                                spreadRadius: 2
                            )
                          ]
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Container(
                              width: ScreenUtil().setHeight(129),
                              height: ScreenUtil().setHeight(79),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/card_left.png'),
                                      fit: BoxFit.fitHeight
                                  )
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: ScreenUtil().setWidth(46),
                              height: ScreenUtil().setHeight(78),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/card_right.png'),
                                      fit: BoxFit.fitWidth
                                  )
                              ),
                            ),
                          ),
                          Container(
                            width: ScreenUtil.screenWidth,
                            padding: EdgeInsets.only(right: 20.0, left: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 26.0, bottom: 26.0),
                                  child: Text('登录', style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600
                                  ),),
                                ),
                                Input(
                                  initValue: username,
                                  placeholder: USERPLACHDER,
                                  valueChanged: (val){
                                    username = val;
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Input(
                                    initValue: password,
                                    placeholder: '请输入密码',
                                    valueChanged: (val){
                                      password = val;
                                    },
                                    hidKeyBord: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: MyButton(
                                    text: '登录',
                                    size: ButtonSize.normal,
                                    type: ButtonType.info,
                                    block: true,
                                    onClick: login,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: GestureDetector(
                                    child: Text("忘记密码", style: TextStyle(
                                        fontSize: 12.0,
                                        color: Theme.of(context).primaryColor
                                    ),),
                                    onTap:  () {
                                       NavigatorUtil.goForgetPassword(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String username = "admin@hlchang.cn";
  String password = "abc12345";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  void getUser(){

  }

  void login(){
    Map<String, dynamic> sendData = {
      "username": username,
      "password": password
    };


    Toast.loading(context, message: '登陆中...');

    getLogin(sendData).then((res) async{
      var data = jsonDecode(res.toString());
       UserData userData = UserData.fromJson(data['data'][0]);
       var str = "${userData.user}:${userData.token}";
       var bytes = utf8.encode(str);
       var encoded = base64Encode(bytes);
       var token = "Basic $encoded";
       await Utils.setToken(token);
      Toast.success(context, message: '登录成功');
      NavigatorUtil.goHome(context);
    }).catchError((e){
      Toast.fail(context, message: '登录失败！！');
    });
  }



}
