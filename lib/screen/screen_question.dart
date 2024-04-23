import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:my_diary/model/model_question.dart';
import 'package:my_diary/screen/screen_edit.dart';
import 'package:my_diary/widget/widget_candidate.dart';
import 'package:my_diary/widget/widget_edit_cand.dart';

class QuestionScreen extends StatefulWidget {
  List<Question> questions;

  QuestionScreen({required this.questions});

  @override
  State<QuestionScreen> createState() =>
      _QuestionScreenState.withDetails(questions.length, questions[0].candNum);
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _quesNum = 3;
  int _currentIndex = 0;
  List<int> _answers = [-1, -1, -1];
  List<bool> _answerState = [false, false, false, false];
  bool _answeringMode = true;
  List<String> editCandidates = [];

  SwiperController _controller = SwiperController();
  _QuestionScreenState();
  _QuestionScreenState.withDetails(this._quesNum, candNum) {
    _answers = List<int>.filled(_quesNum, -1);
    _answerState = List<bool>.filled(candNum, false, growable: true);
    editCandidates = List<String>.filled(candNum, '', growable: true);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  // when mode is changing 'answering' to 'editing'
                  if (_answeringMode == true) {
                    setState(() {
                      _answeringMode = false;
                      for(int i=0; i<widget.questions[_currentIndex].candNum; i++){
                        editCandidates[i]=widget.questions[_currentIndex].candidates[i];
                      }
                    });
                  } else {
                    // when mode is changing 'editing' to 'answering'
                    setState(() {
                      _answeringMode = true;
                      print(editCandidates);
                      for(int i=0; i<editCandidates.length; i++){
                        String s = editCandidates[i];
                        if(s!='') widget.questions[_currentIndex].candidates[i]=s;
                        if(i>=widget.questions[_currentIndex].candidates[i].length){ // 추가된 선택지 반영
                          widget.questions[_currentIndex].candidates.add(s);
                          _answerState.add(false);
                        }
                      }
                    });
                  }
                },
                icon: _answeringMode == true
                    ? Icon(Icons.edit)
                    : Icon(Icons.check))
          ],
        ),
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.deepPurple)),
              width: width * 0.85,
              height: height * 0.5,
              child: Swiper(
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                loop: false,
                itemCount: widget.questions.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildQuestionCard(
                      widget.questions[index], width, height);
                },
              )),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Question question, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
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
              child: Visibility(
                visible: _answeringMode,
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

                      // _answers[_currentIndex]가 -1이면 답변 체크가 안 된 것이므로
                      // 다음으로 넘어가는 걸 막고, 체크가 됐다면 다음으로 넘어가기 위한 함수
                      onPressed: _answers[_currentIndex] != -1
                          ? () {
                              // 마지막 질문이라면 결과창을 띄우기 위한 함수
                              if (_currentIndex ==
                                  widget.questions.length - 1) {
                              } else {
                                _currentIndex += 1;
                                _answerState = List<bool>.filled(
                                    question.candNum, false,
                                    growable: true);
                                _controller.next();
                              }
                            }
                          : null,
                      child: _currentIndex == widget.questions.length - 1
                          ? Text('결과보기')
                          : Text('다음문제'),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  List<Widget> _buildCandidates(double width, Question question) {
    List<Widget> _children = [];

    for (int i = 0; i < question.candNum; i++) {
      _children.add(_answeringMode
          ? CandWidget(
              index: i,
              width: width,
              text: question.candidates[i],
              answerState: _answerState[i],
              tap: () {
                setState(() { // tap한 선택지는 true로 나머지는 false로 토글하고 선택한 답 저장
                  for (int j = 0; j < question.candNum; j++) {
                    if (j == i) {
                      _answerState[j] = true;
                      _answers[_currentIndex] = j;
                      // print(_answers[_currentIndex]); // 누른 선택지 확인
                      //print(width); //  기기 너비 확인
                    } else {
                      _answerState[j] = false;
                    }
                  }
                });
              },
            )
          : EditCandWidget(
            index: i,
            width: width,
            hintText: editCandidates[i],
            onSubmitted: (value) {
              setState(() {
                print(value);
                editCandidates[i] = value;
              });
            },
          ));
      _children.add(Padding(
        padding: EdgeInsets.all(width * 0.024),
      ));
    }
    !_answeringMode
        ? _children.add(IconButton(
            onPressed: () {
              setState(() {
                question.candNum++; // 재렌더링할 때 candNum 값을 기준으로 for문이 돌아서 이걸 증가시켜줘야 됐음. 
                // TODO : 나중에 아예 EditCandWidget이랑 CandWidget이랑 분리시켜서 여기서 candNum을 증가시키지 않아도 되게 수정
                editCandidates.add('');
              });
            },
            icon: Icon(Icons.add)))
        : null;
    return _children;
  }
}
