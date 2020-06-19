import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorHex extends Color{

  ColorHex(String color):super(_getColorFromHex(color));

  static int _getColorFromHex(String color){
    String hex = color.replaceFirst('#', '').toUpperCase();
    if(hex.length == 6){
      hex = 'FF' + hex;
    }
    return int.parse(hex, radix: 16);
  }

}


const String TOKEN = 'token';

class Utils {
  static Timer timer;

  static bool flag = true;


  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  // 防抖函数
  static antiShake(Function fn, Duration time){

    Utils.timer?.cancel();
    Utils.timer = Timer(time, fn);

  }

  // 节流函数
  static throttle(Function fn, Duration time){
    if(Utils.flag){
      Utils.flag = false;
      Future.delayed(time, (){
        fn();
        Utils.flag = true;
      });
    }
  }

  // 通过条件rgb的值将颜色调暗
  static Color setRGB(Color color){
    int R = color.red;
    int G = color.green;
    int B = color.blue;
    double x = 0.8;
    return Color.fromRGBO((R*x).round(), (G*x).round(), (B*x).round(), 0.6);

  }


  // 将数字补零
  static setNumber(int num){
    if(num < 10){
      return '0'+num.toString();
    }else{
      return num.toString();
    }

  }

  // 返回再数组中最接近给定值的位置
  static int getRangValue(List arr, String value){
      int index = arr.length - 1;
      for(var i = 0; i < arr.length; i++){
        if(int.parse(arr[i]) >= int.parse(value)){
          index = i;
          break;
        }
      }
      return index;
  }

  // 获取token
  static Future<bool> setToken(String token) async{
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(TOKEN, token);
  }

  // 获取token
  static Future<String> getToken() async{
    final SharedPreferences prefs = await _prefs;
    return  prefs.getString(TOKEN);
  }


}