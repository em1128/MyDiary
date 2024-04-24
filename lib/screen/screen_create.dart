import 'package:flutter/material.dart';
import 'package:my_diary/model/model_question.dart';

class CreateScreen extends StatelessWidget {
  
  CreateScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    
    
    return SafeArea(
      child: Scaffold(
        body: Text('Hi'),
      )
    );
  }
}