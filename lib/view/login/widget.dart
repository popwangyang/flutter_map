import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widget/button.dart';
import '../../libs/util.dart';

class Button extends StatelessWidget {

  final bool disabled;
  final String text;
  final Function onClick;
  final bool loading;

  Button({
    Key key,
    this.disabled = false,
    this.text = '按钮',
    this.onClick,
    this.loading = false,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    Function click = !disabled ? onClick : null;
    return Container(
      child: MyButton(
        text: text,
        block: true,
        loading: loading,
        color: disabled ? Color.fromRGBO(198, 203, 212, 1):Colors.blue,
        onClick: click,
      ),
    );
  }
}

class Input extends StatelessWidget {

  final String title;
  final String placeholder;
  final TextEditingController controller;
  final Widget verifyCode;
  final Widget rightBox;
  final TextInputType textInputType;
  final int maxLength;

  Input({
    Key key,
    this.title,
    this.placeholder,
    this.controller,
    this.verifyCode,
    this.rightBox,
    this.textInputType = TextInputType.text,
    this.maxLength
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(title, style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(108, 114, 124, 1),
                fontWeight: FontWeight.w400
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: TextField(
              controller: controller,
              keyboardType: textInputType,
              inputFormatters: textInputFormatter,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: Color.fromRGBO(198, 203, 212, 1),
                  fontSize: 14,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorHex('#c6cbd4'),
                    width: 2.0
                  )
                )
              ),
            ),
          ),
          Positioned(
            right: 10.0,
            top: 30.0,
            child: rightBox ?? Container(),
          )
        ],
      ),
    );
  }

  List<TextInputFormatter> get textInputFormatter => [LengthLimitingTextInputFormatter(maxLength)];
}



