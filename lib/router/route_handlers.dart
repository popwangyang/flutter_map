import 'package:fluro/fluro.dart';
import 'fluro_convert_util.dart';
import 'package:flutter/material.dart';
import '../view/splash.dart';
import '../view/login/index.dart';
import '../view/login/forgetPassword.dart';
import '../view/login/setPassword.dart';
import '../bottomNavigateTabBar/index.dart';

var splashHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return new Splash();
  });

var loginHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return new LoginPage();
  });

var forgetPasswordHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params){
      return new ForgetPassword();
    });

var setPasswordHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params){
      String username = params['username']?.first;
      String code = params['code']?.first;
      return new SetPassword(
        username: FluroConvertUtils.fluroCnParamsDecode(username),
        code: FluroConvertUtils.fluroCnParamsDecode(code),
      );
    });

var homedHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params){
      return new HomePage();
    });