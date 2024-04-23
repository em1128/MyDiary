import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class EditCandWidget extends StatefulWidget {
  String hintText;
  int index;
  double width;
  Function(String) onSubmitted;
  // Function(String) onEditingComplete;
  EditCandWidget(
      {required this.index,
      required this.width,
      required this.hintText,
      required this.onSubmitted}) {
    width *= 0.7; // 웹에서 자꾸 다음문제 버튼 나오는 위치가 overflow돼서 안 보여서 선택지 크기를 줄임.
  }

  _EditCandWidgetState createState() => _EditCandWidgetState();
}

class _EditCandWidgetState extends State<EditCandWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.8,
      height: widget.width * 0.1,
      padding: EdgeInsets.fromLTRB(widget.width * 0.048, widget.width * 0.024,
          widget.width * 0.048, widget.width * 0.024),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurple),
      ),

      child: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText:widget.hintText
        ),
        controller: TextEditingController(
          text: widget.hintText
        ),
        onEditingComplete: () {
          FocusScope.of(context).nextFocus(); // 다음 TextField로 포커스 이동
        },
        onSubmitted: widget.onSubmitted,
      )
    );
  }
}
