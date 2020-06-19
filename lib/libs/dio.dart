import 'package:dio/dio.dart';
import 'util.dart';

BaseOptions options = BaseOptions(
  baseUrl: "https://test.bjywkd.com",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio myDio = Dio(options)
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async{
        String token = await Utils.getToken();
        options.headers['Authorization'] = token;
        return options;
      },
      onResponse: (Response response) async{
        return response;
      },
      onError: (DioError e) async{
        print(e);
        return e;
      }
    ));

