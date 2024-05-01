
import 'package:flutter/material.dart';
import 'package:my_diary/model/model_question.dart';
import 'package:my_diary/screen/screen_home.dart';

class ResultScreen extends StatelessWidget{
  List<int> answers;
  List<Question> questions;
  ResultScreen({required this.answers, required this.questions});

  @override
  Widget build(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    int score = 0;
    for(int i=0; i<questions.length; i++){
      if(questions[i].ansCand == answers[i]){
        score +=1 ;
      }
    }

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Diary APP'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple),
                color: Colors.deepPurple,
              ),
              width: width * 0.85,
              height: height * 0.65,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: width * 0.048),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.deepPurple),
                      color: Colors.white,
                    ),
                    width: width * 0.73,
                    height: height * 0.6,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, width * 0.048, 0, width * 0.012),
                          child: Text(
                            '수고하셨습니다!',
                            style: TextStyle(
                              fontSize: width * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '당신의 점수는', 
                          style: TextStyle(
                            fontSize: width * 0.048,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded( // 나머지가 아래쪽으로 배치되도록 Container 추가
                          child: Container()
                        ),
                        Text(
                          score.toString() + '/' + questions.length.toString(),
                          style: TextStyle(
                            fontSize: width * 0.21,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(width * 0.012)
                        )
                      ],
                    ),
                  ),
                  Expanded( // 나머지가 아래쪽으로 배치되도록 Container 추가
                    child: Container(),
                  ),
                ],
              )
            ),
          ),
          bottomSheet: Container(
            padding: EdgeInsets.only(bottom: width * 0.048),
            child: ButtonTheme(
              minWidth: width * 0.73,
              height: height * 0.05,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  minimumSize: Size(width * 0.5, height * 0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 15,
                ),
                onPressed: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return HomeScreen();
                    })
                  );
                },
                child: Text('홈으로 돌아가기'),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
}