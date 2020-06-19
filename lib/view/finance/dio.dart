import 'dart:async';

import 'package:dio/dio.dart';

import '../../libs/dio.dart';

const List<String> province = ['上海', '河北', '山西', '内蒙古', '辽宁', '吉林', '黑龙江', '江苏', '浙江', '安徽', '福建', '江西', '山东', '河南', '湖北', '湖南', '广东', '广西', '海南', '四川', '贵州', '云南', '西藏', '陕西', '甘肃', '青海', '宁夏', '新疆', '北京', '天津', '重庆', '香港', '澳门','台湾', '全国'];

/// 获取统计数据
Future getStatisticalData (Map<String, dynamic> params) {
  return myDio.get('/ktv/place/statistics-overview', queryParameters: params);
}

/// 获取订单数据
Future getOrderStatistical () {
  return myDio.get('/order/order-total-statistics');
}

/// 获取地图数据
Future getMapData(Map<String, dynamic> params){
  return myDio.get('/ktv/place/statistics-table', queryParameters: params);
}

/// 获取开通场所数量
Future getAllContractingKtv(Map<String, dynamic> params){
  return myDio.get('/ktv/place/contracting-ktv', queryParameters: params);
}

Future region(Map<String, dynamic> params) async{
  Completer _completer = Completer();

  try{
    Response mapData = await getMapData(params);
    Response contractKtvData = await getAllContractingKtv(params);

    List<Map<String, dynamic>> results = [];
    // ignore: unnecessary_statements
    List data = mapData.data as List;

    province.forEach((item){
      Map<String, dynamic> itemObj = {
        'ktv':0,
        'city':0,
        'count':0,
        'name': item,
        'allKtv':contractKtvData.data['contracting_count']
      };

      Map<String, dynamic> flag = data.firstWhere((dataItem){
        String province = dataItem['province'];
        return item.indexOf(province) > -1;
      }, orElse: () => null);

      if(flag != null){
        itemObj['ktv'] = flag['sign_num_ktv'];
        itemObj['city'] = flag['grant_num_city'];
        itemObj['count'] = flag['sign_num_room'];
      }

      results.add(itemObj);

    });

    _completer.complete(results);

  }on DioError catch(e){
    _completer.completeError(e);
  }
  return _completer.future;
}