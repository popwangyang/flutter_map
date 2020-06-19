import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../router/navigatorUtil.dart';
import '../../view/login/dio.dart';
import '../../widget/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widget/content.dart';
import '../../widget/appBar.dart';
import './widget.dart';

enum VerificationMethod {
  email,
  phone
}

enum VerifyStatues {
  text,
  loading,
  number
}

typedef callBack<T> = T Function();

const int CODE_TIMER = 60;

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(667),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appTitle(title: '$text验证'),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: ContentUnFocus(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: <Widget>[
                  title(),
                  Input(
                    title: text,
                    placeholder: '请输入$text',
                    controller: userController,
                    textInputType: userTextInputType,
                  ),
                  Input(
                    title: '验证码',
                    placeholder: '请输入验证码',
                    controller: codeController,
                    rightBox: verifyCode(),
                    textInputType: TextInputType.number,
                    maxLength: 4,
                  ),
                  Button(
                    loading: loading,
                    disabled: disabled,
                    text: '下一步',
                    onClick: _nextBtn,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: GestureDetector(
                      child: Text('通过$textBottom找回密码', style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(50, 109, 242, 1)
                      ),),
                      onTap: _changMethod,
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

  Widget title(){
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text('手机号验证', style: method == VerificationMethod.phone ? title0:title1),
          ),
          Text('邮箱验证', style:  method == VerificationMethod.email ? title0:title1),
        ],
      ),
    );
  }


  /// code 部分

  Widget verifyCode(){
    return Container(
      child: (){
        Widget result;
        switch(_verifyStatues){
          case VerifyStatues.text:
            result = textBox();
            break;
          case VerifyStatues.loading:
            result =  loadingBox();
            break;
          case VerifyStatues.number:
            result =  numberBox();
            break;
        }
        return result;
      }(),
    );
  }

  Widget textBox(){
    return GestureDetector(
      child: Text('获取验证码', style: _codeStyle,),
      onTap: getCode,
    );
  }

  Widget loadingBox(){
    return Container(
      width: 20.0,
      height: 20.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: CircularProgressIndicator(strokeWidth: 2.0,),
    );
  }

  Widget numberBox(){
    return Container(
      width: 70.0,
      alignment: Alignment.center,
      child: Text('${_number}s', style: _codeStyle,),
    );
  }

  TextStyle title0 = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(2, 2, 2, 1)
  );

  TextStyle title1 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(108, 114, 124, 1)
  );

  VerificationMethod method = VerificationMethod.phone;
  TextEditingController userController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String username = '';
  String code = '';
//  bool disabled = true;
  bool loading = false;
  Timer timer;
  RegExp phoneRegExp = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
  RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$');

  String get key => method == VerificationMethod.phone ? 'phone':'email';
  String get text => method == VerificationMethod.phone ? '手机号':'邮箱';
  String get textBottom => method != VerificationMethod.phone ? '手机号':'邮箱';
  bool get disabled => userController.text == '' || codeController.text == '';
  TextInputType get userTextInputType => method == VerificationMethod.phone ? TextInputType.phone : TextInputType.emailAddress;
  VerifyStatues _verifyStatues = VerifyStatues.text;
  int _number = CODE_TIMER;
  TextStyle _codeStyle = TextStyle(
      color: Color.fromRGBO(75, 116, 255, 1),
      fontSize: 14,
      fontWeight: FontWeight.w600
  );



  bool _verify(){
    if(userController.text == '') {
      Toast(context, message: '$text不能为空');
      return false;
    }else{
      RegExp _reg = method == VerificationMethod.phone ? phoneRegExp:emailRegExp;
      bool matched = _reg.hasMatch(userController.text);
      if(!matched){
        Toast(context, message: '$text格式不正确');
        return false;
      }
      return true;
    }
  }

  void _nextBtn() async{

    setState(() {
      loading = true;
    });
    try{
      var sendData = {
        'code': codeController.text,
        key: userController.text
      };
      Response response = await testIdentifyCode(sendData);
      setState(() {
        loading = false;
      });
      Toast(context, duration: 1000, message: '验证成功');
      Timer(Duration(seconds: 1), (){
        NavigatorUtil.goSetPassword(context, userController.text, codeController.text);
      });
    } on DioError catch(e){
      if(e.response.statusCode == 406){
        Toast(context, message: e.response.data['error']);
      }
      setState(() {
        loading = false;
      });


    }

  }

  void _changMethod(){
    if(method == VerificationMethod.phone){
      method = VerificationMethod.email;
    }else{
      method = VerificationMethod.phone;
    }
    codeController.clear();
    userController.clear();
    clearTimer();
    setState(() {});
  }

  void getCode() async{
    bool flag =  _verify();
    if(!flag) return;
    setState(() {
      _verifyStatues = VerifyStatues.loading;
    });
    try{
      var sendData = {
        key: userController.text
      };
      await getIdentifyCode(sendData);
      setState(() {
        _verifyStatues = VerifyStatues.number;
        startCode();
      });
      Toast(context, message: '验证码已发送至$text');

    }on DioError catch(e){
      setState(() {
        _verifyStatues = VerifyStatues.text;
      });
    }
  }

  void startCode(){
    if(timer != null && timer.isActive){
      timer.cancel();
    }
    _number = CODE_TIMER;
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer){
      if(_number < 1){
        clearTimer();
      }else{
        setState(() {
          _number--;
        });
      }
    });
  }

  void clearTimer(){
    if(timer != null && timer.isActive){
      timer.cancel();
    }
    setState(() {
      _verifyStatues = VerifyStatues.text;
    });
  }


 @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if(timer != null && timer.isActive){
      timer.cancel();
    }
  }
}







