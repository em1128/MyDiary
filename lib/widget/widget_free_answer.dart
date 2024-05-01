import 'package:flutter/material.dart';

class FreeAnaswerWidget extends StatefulWidget {
  Function(String) onChanged;
  double width;
  bool answeringMode;

  FreeAnaswerWidget({ required this.width, required this.answeringMode, required this.onChanged});

  _FreeAnaswerWidgetState createState() => _FreeAnaswerWidgetState();
}

class _FreeAnaswerWidgetState extends State<FreeAnaswerWidget> {
  @override
  Widget build(BuildContext context) {
    return  TextField(
            decoration: InputDecoration(
              constraints: BoxConstraints(maxWidth: widget.width*0.7),
              counterText: '',
            ),
            maxLength: 800,
            maxLines: null,
            textInputAction: TextInputAction.newline,
            onChanged:(value) {
              setState(() {
                widget.onChanged(value);
              });
            },
            readOnly: !widget.answeringMode,
            autofocus: true,
          );

  }
}