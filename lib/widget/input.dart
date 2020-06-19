import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 Border hasFocusBorder = Border.all(color: Colors.blue, width: 2);
 Border unFocusBorder = Border.all(color: Color(0xffCCCCCC), width: 1);


class Input extends StatefulWidget {

  final String placeholder;
  final String initValue;
  final ValueChanged<String> valueChanged;
  final TextInputType type;
  final bool hidKeyBord;

  Input({
    Key key,
    this.placeholder = "请输入...",
    this.initValue,
    this.valueChanged,
    this.type = TextInputType.text,
    this.hidKeyBord = false


  }):super(key :key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(44),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border:  _hasFocus ? hasFocusBorder : unFocusBorder,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: widget.type,
                obscureText: widget.hidKeyBord,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(
                      color: Color(0xffCCCCCC),
                      fontSize: 14.0
                  ),
                  border: InputBorder.none
                ),
              ),
            ),
          ),
          Opacity(
            opacity: _hasFocus && _controller.text != '' ? 1.0:0.0,
            child:  Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: GestureDetector(
                onTap: clearBtn,
                child: Icon(Icons.highlight_off, color: Color(0xffCCCCCC), size: 18,),
              ),
            ),
          )
        ],
      ),
    );
  }

  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {

    super.initState();
    if(widget.initValue != null){
      _controller.text = widget.initValue;
    }
   _controller.addListener(() {

     if(widget.valueChanged != null){
       widget.valueChanged(_controller.text);
     }

     print(_controller.text);

     setState(() {});
   });

    _focusNode.addListener((){
      if(_focusNode.hasFocus){
        this._hasFocus = true;
      }else{
        this._hasFocus = false;
      }
      setState(() {});
    });

  }


  void clearBtn(){
    if(_controller.text == '') return;
    _controller.text = "";
  }

}
