import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:my_diary/model/model_question.dart';
import 'package:my_diary/widget/widget_candidate.dart';
import 'package:my_diary/widget/widget_edit_cand.dart';

class QuestionScreen extends StatefulWidget {
  List<Question> questions;

  QuestionScreen({required this.questions});

  @override
  State<QuestionScreen> createState() =>
      _QuestionScreenState(questions.length, questions[0].candNum);
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _quesNum = 3;
  int _currentIndex = 0;
  List<int> _answers = [-1, -1, -1];
  List<bool> _answerState = [false, false, false, false];
  bool _answeringMode = true; // toggle with editing
  List<String> _editCandidates =[];
  int _deleteIndex = -1;
  List<String> _answerString =[];
  SwiperController _controller = SwiperController();

  _QuestionScreenState(this._quesNum, candNum) {
    _answers = List<int>.filled(_quesNum, -1);
    _answerState = List<bool>.filled(candNum, false, growable: true);
    _editCandidates = List<String>.filled(candNum, '', growable: true);
    _answerString = List<String>.filled(_quesNum, '');
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    double bodyHeight = height * 0.75;
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          actions: [
            Visibility(
              visible: (!_answeringMode && widget.questions[_currentIndex].candNum>0),
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  setState(() {
                    if(widget.questions[_currentIndex].candNum<=0){
                      print("NO CANDIDATE TO DELETE");
                    }else if(_deleteIndex!=-1 ){
                      _editCandidates.removeAt(_deleteIndex);
                      _answerState.removeAt(_deleteIndex);
                      widget.questions[_currentIndex].candNum--;
                    }
                  });
                } 
              ),
            ),
            _buildToggleButton()
          ],
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple)),
            width: width * 0.85,
            height: bodyHeight,
            child: Swiper(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              loop: false,
              itemCount: widget.questions.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuestionCard(width, height);
              },
            )
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(){
    return IconButton(
      icon: _answeringMode == true
          ? Icon(Icons.edit)
          : Icon(Icons.check),
      onPressed: () {
        // when mode is changing 'answering' to 'editing'
        if (_answeringMode == true) {
          setState(() {
            _answeringMode = false;
            for(int i=0; i<widget.questions[_currentIndex].candNum; i++){
              _editCandidates[i]=widget.questions[_currentIndex].candidates[i];
            }
          });
        } else {
          // when mode is changing 'editing' to 'answering'
          setState(() {
            _answeringMode = true;
            print(_editCandidates);
            for(int i=0; i<_editCandidates.length; i++){
              String s = _editCandidates[i];
              if(i>=widget.questions[_currentIndex].candNum){ // 추가된 선택지 반영
                widget.questions[_currentIndex].candidates.add(s);
                widget.questions[_currentIndex].candNum++;
                _answerState.add(false);
              }
              else if(s!='') {
                widget.questions[_currentIndex].candidates[i]=s;
              }
            }
          });
        }
      },
    );
  }
  Widget _buildQuestionCard(double width, double height) {
    /* 기존에는 Question question을 파라미터로 받아왔으나,
     * question의 내용을 수정해야 해서 
     * local variable로는 쓸 수 없게 됨.
     */
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
              widget.questions[_currentIndex].title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Expanded(// 빈 Container인데, 이게 있어야 이후에 배치될 children들을 아래쪽으로 배치시킴.
          //   child: Container(),
          // ),
          Column(
            children: _buildAnswers(width, height, widget.questions[_currentIndex]),
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
                            if (_currentIndex == widget.questions.length - 1) {
                            } else {
                              _currentIndex += 1;
                              _answerState = List<bool>.filled(widget.questions[_currentIndex].candNum, false, growable: true);
                              _editCandidates = List<String>.filled(widget.questions[_currentIndex].candNum, '', growable: true);
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
            )
          )
        ],
      ),
    );
  }

  List<Widget> _buildAnswers(double width, double height, Question question) {
    List<Widget> _children = [];
    if(question.candNum<=0){ // free answer
      _children.add(
        TextField(
          decoration: InputDecoration(
            constraints: BoxConstraints(maxWidth: width*0.7),
            counterText: '',
          ),
          maxLength: 800,
          maxLines: null,
          textInputAction: TextInputAction.newline,
          onChanged:(value) {
            setState(() {
              _answerString[_currentIndex]=value;
              _answers[_currentIndex]=0;
            });
          },
          
          readOnly: !_answeringMode,
          autofocus: true,
        )
      );
    }
    if(_answeringMode==true){ // answer by candidate 
      for (int i = 0; i < question.candNum; i++) {
        _children.add(
          CandWidget(
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
        );
        _children.add(Padding(
          padding: EdgeInsets.all(height * 0.018),
        ));
      }
    }
    else{// edit candidate 
      for (int i = 0; i < _editCandidates.length; i++) {
        _children.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio( 
                value: i,
                groupValue: _deleteIndex, 
                onChanged: (value){
                  setState(() {
                    print(value);
                    _deleteIndex = value!;

                  });
                }
              ),
              EditCandWidget(
                index: i,
                width: width,
                hintText: _editCandidates[i],
                onSubmitted: (value) {
                  setState(() {
                    print(_editCandidates);
                    _editCandidates[i] = value;
                  });
                },
              ),
            ],
          ));
        _children.add(Padding(
          padding: EdgeInsets.all(width * 0.024),
        ));
      }
      _children.add(IconButton(
        onPressed: () {
          setState(() {
            _editCandidates.add('');
          });
        },
        icon: Icon(Icons.add)));
    }
    return _children;
  }
}
