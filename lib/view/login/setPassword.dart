import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../view/login/dio.dart';
import '../../widget/toast.dart';
import './widget.dart';
import '../../widget/content.dart';
import '../../router/navigatorUtil.dart';
import '../../widget/appBar.dart';

class SetPassword extends StatefulWidget {

  final String username;
  final String code;

  SetPassword({Key key, this.username, this.code}):super(key: key);

  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appTitle(title: '新密码登录'),
        body: Container(
          child: SingleChildScrollView(
            child: ContentUnFocus(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: <Widget>[
                    title(),
                    Input(
                      controller: inputController1,
                      title: '新密码',
                      placeholder: '请输入新密码',
                    ),
                    Input(
                      controller: inputController2,
                      title: '确认密码',
                      placeholder: '请再次输入新密码',
                    ),
                    Button(
                      text: '完成',
                      disabled: disabled,
                      loading: loading,
                      onClick: confirmBtn,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget title(){
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text('新密码', style:TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(2, 2, 2, 1)
            )),
          ),

        ],
      ),
    );
  }
  TextEditingController inputController1 = TextEditingController();
  TextEditingController inputController2 = TextEditingController();
  RegExp regExp = RegExp(r'^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$');
  bool get disabled => inputController1.text == '' || inputController2.text == '';
  bool loading = false;


  String testForm(){
    if(inputController1.text != inputController2.text) return '两次密码输入不一致';
    if(!regExp.hasMatch(inputController1.text)) return '请输入6~20位数字和字母组合';
    return null;
  }

  void confirmBtn() async{
    String testResult = testForm();

    if(testResult != null){
      Toast(context, message: testResult);
    }else{
      var sendData = {
        "username": widget.username,
        "code": widget.code,
        "password": inputController1.text
      };
      try{
        setState(() {
          loading = true;
        });
        await confirmToModifyTheNewPassword(sendData);
        Toast(context, duration: 1000, message: '密码修改成功');
        setState(() {
          loading = false;
        });
        Timer(Duration(seconds: 1), (){
          NavigatorUtil.goLogin(context);
        });
      } on DioError catch(e){
        print(e.response.data);
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }


}
