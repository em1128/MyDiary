import 'package:flutter/material.dart';

class StarWidget extends StatefulWidget {
  VoidCallback tap;
  double width;
  int answer;

  StarWidget({ required this.width, required this.answer, required this.tap});

  _StarWidgetState createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      child: Icon(Icons.star),
      onTap: (){
        setState(() {
          widget.tap();
          widget.answer = 0;
          print(widget.answer);
        });
      },
    );

  }
}