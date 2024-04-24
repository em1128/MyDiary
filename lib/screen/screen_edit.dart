import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_diary/model/model_question.dart';
import 'package:my_diary/widget/widget_candidate.dart';
class EditScreen extends StatefulWidget {
  List<Question> questions;
  int index;
  EditScreen({required this.questions, required this.index});

  @override
  State<EditScreen> createState() => _EditScreenState(index);
}

class _EditScreenState extends State<EditScreen> {
  int _currentIndex = 0;
  _EditScreenState(int index){
    _currentIndex = index;
  }
  @override
  Widget build(BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  double width = screenSize.width;
  double height = screenSize.height;
  
  
  return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.deepPurple)
          ),
          width: width * 0.85,
          height: height * 0.5,
          child: _buildQuestionCard(widget.questions[_currentIndex], width, height),
          )
        ),
      ),
    );
  }
  Widget _buildQuestionCard(Question question, double width, double height){
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q' + (_currentIndex + 1).toString() + '.',
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            // 자동으로 text size 조정
            child: AutoSizeText(
              question.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // 빈 Container인데, 이게 있어야 이후에 배치될 children들을 아래쪽으로 배치시킴.
          Expanded(
            child: Container(),
          ),
          Column(
            children: _buildCandidates(width, question),
          ),
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                    minimumSize: Size(width * 0.5, height * 0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 15,
                  ),
                  child: _currentIndex == widget.questions.length - 1 
                  ? Text('결과보기') 
                  : Text('다음문제'),
                  onPressed: null,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  List<Widget> _buildCandidates(double width, Question question){
    List<Widget> _children = [];
    for(int i=0; i<question.candNum; i++){
      _children.add(
        CandWidget(
          index: i, 
          width: width, 
          text: question.candidates[i], 
          answerState: false,
          tap: (){}, 
        )
      );
      _children.add(
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        )
      );
    }
    return _children;
  }
}