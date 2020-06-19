import '../../libs/dio.dart';

Future getLogin (Map<String, dynamic> data) {
  print(data);
  return myDio.post('/cperm/token/get', data: data);
}

/// 获取用户类型
Future getUserType (Map<String, dynamic> params) {
  return myDio.get('/cperm/users/user_type', queryParameters: params);
}

/// 根据手机号或邮箱获取验证码
Future getIdentifyCode (Map<String, dynamic> data) {
  return myDio.post('/cperm/send_code', data: data);
}

/// 验证验证码
Future testIdentifyCode (Map<String, dynamic> data) {
  return myDio.post('/cperm/verify_code', data: data);
}

/// 修改密码(非登录状态)
Future confirmToModifyTheNewPassword (Map<String, dynamic> data) {
  return myDio.post('/cperm/user/change_password', data: data);
}