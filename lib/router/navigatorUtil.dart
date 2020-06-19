import 'package:flutter/cupertino.dart';
import 'fluro_convert_util.dart';
import 'application.dart';
import 'routes.dart';

class NavigatorUtil {

  /// 跳转到登录页面
  static void goLogin(BuildContext context){
    Application.router.navigateTo(context, Routes.login, clearStack: true);
  }

  /// 忘记密码
  static void goForgetPassword(BuildContext context){
    Application.router.navigateTo(context, Routes.forgetPassword);
  }

  /// 设置密码
  static void goSetPassword(BuildContext context, String username, String code){
    String URL = "${Routes.setPassword}?username=${FluroConvertUtils.fluroCnParamsEncode(username)}&code=${FluroConvertUtils.fluroCnParamsEncode(code)}";
    Application.router.navigateTo(context, URL);
  }

  /// home页面
  static void goHome(BuildContext context) {
    Application.router.navigateTo(context, Routes.home, clearStack: true);
  }
}