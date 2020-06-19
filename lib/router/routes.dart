import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import '../router/route_handlers.dart';
import '../router/routes.dart';

class Routes {
  static String root = '/';
  static String home = '/home';
  static String login = './login';
  static String forgetPassword = '/forgetPassword';
  static String setPassword = '/setPassword';

  static void configureRoutes(Router router){

    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        return Container();
      });

    router.define(root, handler: splashHandler);
    router.define(login, handler: loginHandler);
    router.define(forgetPassword, handler: forgetPasswordHandler);
    router.define(setPassword, handler: setPasswordHandler);

    /// home页面
    router.define(home, handler: homedHandler);



  }


}