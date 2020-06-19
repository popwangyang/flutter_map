import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import '../dio.dart';
import 'dart:convert';

class Circular extends StatefulWidget {
  @override
  _CircularState createState() => _CircularState();
}

class _CircularState extends State<Circular> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
      height: ScreenUtil().setHeight(220),
      child: Column(
        children: <Widget>[
          CustomTab(
            controller: controller,
            itemWidth: 120.0,
            titleList: [
              '扫码计费收入',
              '扫码计费订单'
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CircularContent(
                    value: double.parse(musicAmount) / double.parse(amount),
                    valueColor: Colors.blue,
                    title: '总收入',
                    titleValue: "￥$amount",
                    content: Builder(
                      builder: (context){
                        return Container(
                          child: Column(
                            children: <Widget>[
                              columnListItem('综合服务费', '￥$musicAmount', Colors.blue),
                              columnListItem('商户开房套餐', '￥$packageAmount', Color.fromRGBO(236, 236, 236, 1)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  CircularContent(
                    value: double.parse(refundCount) / double.parse(count),
                    valueColor: Color.fromRGBO(1, 204, 163, 1),
                    title: "订单总数",
                    titleValue: count,
                    content: Builder(
                      builder: (context){
                        return Container(
                          child: Column(
                            children: <Widget>[
                              columnListItem('退款订单', refundCount, Color.fromRGBO(1, 204, 163, 1)),
                              columnListItem('退款金额', '￥$refundAmount', Colors.white),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget columnListItem(String title, String money, Color color){
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 9.0,
                  height: 9.0,
                  margin: EdgeInsets.only(right: 4.0),
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.all(
                          Radius.circular(6.0)
                      )
                  ),
                ),
                Text(title, style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(140, 140, 140, 1),
                ),)
              ],
            ),
          ),
          Text(money, style: _moneyStyle,)
        ],
      ),
    );
  }

  TextStyle _moneyStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  CustomController controller = CustomController();
  PageController pageController = PageController();

  String amount = '1.00';
  String musicAmount = '0.00';
  String packageAmount = '0.00';
  String count = '1';
  String refundCount = '0';
  String refundAmount = '0.00';


  @override
  void initState() {
    controller.addListener((){
      pageController.animateToPage(
          controller.pageIndex,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut
      );
    });
    getData();
    super.initState();
  }

  Future getData() async{
    try{
      Response response = await getOrderStatistical();
      var data = response.data;
      setState(() {
        amount = data['amount'].toString();
        musicAmount = data['music_amount_display'].toString();
        packageAmount = data['package_amount_display'].toString();
        count = data['count'].toString();
        refundCount = data['refund_count'].toString();
        refundAmount = data['refund_amount_display'].toString();
      });
    }on DioError catch(e){
      print(e);
    }
  }





}


// ignore: must_be_immutable
class CircularContent extends StatelessWidget {

  final double value;
  final Color valueColor;
  final String title;
  final String titleValue;
  final Builder content;

  CircularContent({
    this.value = 0.5,
    this.valueColor = const Color.fromRGBO(0, 130, 225, 1),
    this.title,
    this.titleValue,
    this.content
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 140,
            height: 140,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 18.0,
                backgroundColor: Color.fromRGBO(236, 236, 236, 1),
                valueColor: AlwaysStoppedAnimation<Color>(valueColor),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(title, style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),),
                      Text(titleValue, style: _moneyStyle,)
                    ],
                  ),
                  content,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle _moneyStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );


}



/// customTab控制器
class CustomController extends ChangeNotifier{

  int get pageIndex => _index;
  int _index = 0;

  void setIndex(int index){
    _index = index;
    notifyListeners();
  }


  void jumpTo(int index){
    _index = index;
    notifyListeners();
  }


}

class CustomTab extends StatefulWidget {

  final CustomController controller;
  final double itemWidth;
  final List<String> titleList;


  CustomTab({
    this.controller,
    this.itemWidth = 120,
    this.titleList
  });


  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TitleBox(
            selectedIndex: _index,
            valueChanged: tabBtn,
            titleList: widget.titleList,
            itemWidth: widget.itemWidth,
          ),
          LineAnimation(
            position: positions[_index]
          ),
        ],
      ),
    );
  }

  int _index = 0;

  List<double> positions = [];


  @override
  void initState() {
    if(widget.controller != null){
      widget.controller.addListener((){
        setState(() {
          _index = widget.controller._index;
        });
      });
    }


    for(var i = 0; i < widget.titleList.length; i++){
      double value = widget.itemWidth * (i + 1) - widget.itemWidth/2;
      positions.add(value);
    }

    super.initState();
  }

  void tabBtn(int index){
    print(widget.controller);
    widget.controller.setIndex(index);
  }

}



/// 自定义text部分
// ignore: must_be_immutable
class TitleBox extends StatelessWidget {

  final int selectedIndex;
  final ValueChanged<int> valueChanged;
  final double itemWidth;
  final List<String> titleList;

  TitleBox({
    this.selectedIndex,
    this.valueChanged,
    this.itemWidth = 120,
    @required this.titleList
  })
  : assert(titleList.length > 1);


  TextStyle _selectedStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: Colors.black
  );

  TextStyle _unselectedStyle = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(183, 183, 183, 1)
  );

  int _index = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: titleList.map((item){
          ++_index;
          return listItem(item, valueChanged, _index);
        }).toList(),
      ),
    );
  }

  Widget listItem( String title, ValueChanged<int> btn, int index){
    return GestureDetector(
      child: Container(
          width: itemWidth,
          alignment: Alignment.center,
          child: Text(title, style: selectedIndex == index ? _selectedStyle:_unselectedStyle,)
      ),
      onTap: (){
        btn(index);
      },
      behavior: HitTestBehavior.translucent,
    );
  }
}




/// 自定义tab组件
class LineAnimation extends StatefulWidget {
  final double position;
  final double lineWidth;
  final Duration duration;
  final Curve curve;

  LineAnimation({
    @required this.position,
    this.lineWidth = 20.0,
    this.duration = const Duration(milliseconds: 150),
    this.curve =  Curves.easeInOut
  });

  @override
  _LineAnimationState createState() => _LineAnimationState();
}

class _LineAnimationState extends State<LineAnimation> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  CurvedAnimation _curvedAnimation;
  double _left;
  double _right;
  double _boxWidth;
  bool _direction;  /// true为正向运动，false为反向运动；
  double _leftPosition;
  double _rightPosition;
  double _widthMin;
  double _widthMax;

  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    _left = widget.position - widget.lineWidth/2;
    _widthMin = widget.lineWidth;
    _widthMax = widget.lineWidth;
    super.initState();
  }

  /// 获取控件的宽度
  double _getWidth(){
    if(_boxWidth != null){
      return _boxWidth;
    } else{
      final RenderBox box = _globalKey.currentContext.findRenderObject();
      _boxWidth = box.size.width;
      return _boxWidth;
    }
  }
  /// 设置动画参数
  void setParam(double oldPosition, double newPosition){
    _direction = oldPosition < newPosition ? true:false;
    _widthMax = (oldPosition - newPosition).abs();
    _rightPosition = _getWidth() - (math.max(oldPosition, newPosition) + widget.lineWidth/2);
    _leftPosition = math.min(oldPosition, newPosition)- widget.lineWidth/2;
    if(_controller != null) {
      _controller.dispose();
    }
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _curvedAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _animation = Tween(begin: _widthMin, end: _widthMax).animate(_curvedAnimation);
    _controller.addListener((){
      setState(() {});
    });
    _controller.addStatusListener((AnimationStatus animationStatus){
      switch(animationStatus){
        case AnimationStatus.forward:
          _left = _direction ? _leftPosition:null;
          _right = _direction ? null:_rightPosition;
          break;
        case AnimationStatus.completed:
          _controller.reverse();
          break;
        case AnimationStatus.reverse:
          _left = _direction ? null:_leftPosition;
          _right = _direction ? _rightPosition:null;
          break;
        case AnimationStatus.dismissed:
          break;
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LineAnimation oldWidget) {
    if(oldWidget.position != widget.position){
      setParam(oldWidget.position, widget.position);
    }
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  Widget build(BuildContext context) {
//    print(context.size);
    return Container(
      key: _globalKey,
      height: 5.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
            style: BorderStyle.solid
          )
        )
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: _left,
            right: _right,
            height: 5.0,
            width: _animation == null ? widget.lineWidth:_animation.value,
            child: Container(
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}







