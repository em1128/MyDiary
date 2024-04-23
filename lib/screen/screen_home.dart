import 'package:flutter/material.dart';
import 'package:my_diary/model/model_question.dart';
import 'package:my_diary/screen/screen_create.dart';
import 'package:my_diary/screen/screen_question.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{
  List<Question> questions = [
    Question.fromMap({
      'title': 'question',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0,
      'candNum': 4
    }),
    Question.fromMap({
      'title': 'question',
      'candidates': ['e', 'f', 'g', 'h'],
      'answer': 0,
      'candNum': 4
    }),
    Question.fromMap({
      'title': 'question',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0,
      'candNum': 4
    }),
  ];
  @override
  Widget build(BuildContext context){
    //MediaQuery 적용
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Diary App'),
          backgroundColor: Colors.deepPurple,
          leading:Container(), 
          // leading이 페이지 이동시 자동으로 생겨나는 뒤로가기 지울 수 있음
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
              'assets/images/quiz.jpeg', 
              width: width *0.8
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.024),
            ),
            Text(
              '플러터 다이어리 앱', 
              style: TextStyle(
                fontSize: width * 0.065,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.048),
            ),
            _buildStep(width, '1. 예, 아니오 질문에 답해주세요.'),
            _buildStep(width, '2. 선택지가 있는 질문에 답해주세요.'),
            _buildStep(width, '3. 질문에 대해 자유롭게 답해주세요.'),
            Padding(
              padding: EdgeInsets.all(width * 0.048),
            ),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.036),
              child: Column(
                children: <Widget>[
                  ButtonTheme(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: Size(width * 0.8, height * 0.05),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => QuestionScreen(
                              questions: questions,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        '작성',
                        style: TextStyle(color: Colors.white),
                      ),
                      
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(width * 0.024),
                  ),
                  ButtonTheme(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: Size(width * 0.8, height * 0.05),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => CreateScreen(
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        '수정',
                        style: TextStyle(color: Colors.white),
                      ),
                      
                    ),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(double width, String title){
    return Container(
      padding: EdgeInsets.fromLTRB(
        width * 0.048,
        width * 0.024,
        width * 0.048,
        width * 0.024,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(
              padding: EdgeInsets.only(right: width * 0.024),
          ),
          Text(title),
        ],
      ),
    );
  }
}