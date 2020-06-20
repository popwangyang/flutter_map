import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../dio.dart';
import '../assets/province.dart' show china;

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      color: Colors.yellow,
      child: Echarts(
        extensions: [china],
        option: '''
          {
           visualMap: {
                  type: 'piecewise',
                  bottom: 8,
                  splitNumber: 5,
                  itemWidth: 8,
                  itemHeight: 8,
                  textGap: 4,
                  pieces: [{
                            gt: 80,
                            label: '> 80 单位: %'
                            },
                          {
                            gt: 60,
                            lte: 80,
                            label: '60~80'
                          },
                          {
                            gt: 45,
                            lte: 60,
                            label: '45~60'
                          },
                          {
                            gt: 30,
                            lte: 45,
                            label: '30~45'
                          },
                          {
                            gt: 15,
                            lte: 30,
                            label: '15~30'
                          },
                          {
                            gte: 0,
                            lte: 15,
                            label: '0~15'
                          }],
                  orient: 'horizontal',
                  inRange: {
                    color:  ['#fafcff', '#D2E9FF', '#90C8FF', '#4DA6FC', '#0082FF'],
                    symbolSize: [0, 1000],
                    symbol: 'circle'
                  },
                  show:true,//是否显示组件
                  textStyle: {
                    color: 'black',
                    fontSize: 10,
                  }
                },
                series : [
                   {
                    name: 'china',
                    type: 'map',
                    mapType: 'china',
                    roam: false,//是否开启鼠标缩放和平移漫游
                    itemStyle: {//地图区域的多边形 图形样式
                      normal: {//是图形在默认状态下的样式
                        label: {
                          show: false,//是否显示标签
                          textStyle: {
                            color: "red"
                          }
                        }
                      },
                      emphasis: {//是图形在高亮状态下的样式,比如在鼠标悬浮或者图例联动高亮时
                        label: { show: false }
                      }
                    },
                    data: $tmpSeriesData,
                    top: "3%"//组件距离容器的距离
                  }
                ]
            }
        ''',
      ),
    );
  }

  var tmpSeriesData;


  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async{
    var params = {
      'name':'全国',
      'level': 1
    };
    var data = await region(params) as List;

    var listData = data.map((item){
       item['value'] = (item['ktv'] / item['allKtv']) * 100;
       item['itemStyle'] = {
         'normal': {
           'borderColor': item['value'] == 0 ? '#e43c59':'#cecece',
           'color': '#FFF'
         },
       };
       return item;
    }).toList();
    tmpSeriesData = jsonEncode(listData);
    setState(() {});
  }

}
