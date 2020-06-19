import 'package:flutter/material.dart';
import '../view/finance/index.dart';
import '../view/ktv/index.dart';
import '../view/order/index.dart';
import '../view/person/index.dart';
import '../widget/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(
        onWillPop: () async{
          if(_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)){
            _lastPressedAt = DateTime.now();
            Toast(context, message: '再按一次退出');
            return false;
          }
          return true;
        },
        child: Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: items(bottomList),
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12.0,
            onTap: (int index){
              setState(() {
                currentIndex = index;
              });
            },
          ),

        ),
      ),
    );
  }

  List<BottomNavigationBarItem> items(List<BottomItem> list){
    return list.map((item) {
      return BottomNavigationBarItem(
          icon: Image(
            image: AssetImage(item.url),
            height: 20.0,
          ),
          activeIcon: Image(
            image: AssetImage(item.activeUrl),
            height: 20.0,
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(item.name, style: TextStyle(
                color: item.index != currentIndex ? Color.fromRGBO(183, 183, 183, 1):Colors.blue,
                fontSize: 12,
                fontWeight: FontWeight.w600),),
          )
      );
    }).toList();
  }

  List<BottomItem> bottomList = [
    BottomItem("财务管理", "images/bottomTabs/mainB.png", "images/bottomTabs/mainA.png", 0),
    BottomItem("KTV管理", "images/bottomTabs/ktvB.png","images/bottomTabs/ktvA.png", 1),
    BottomItem("订单分成", "images/bottomTabs/OrderB.png","images/bottomTabs/OrderA.png", 2),
    BottomItem("个人中心", "images/bottomTabs/personB.png","images/bottomTabs/personA.png", 3),
  ];

  int currentIndex = 0;

  List<Widget> pages = [
    Finance(),
    KtvPage(),
    OrderPage(),
    PersonPage(),
  ];

  DateTime _lastPressedAt;






}


class BottomItem {
  String name;
  String url;
  String activeUrl;
  int index;

  BottomItem(this.name, this.url, this.activeUrl, this.index);
}