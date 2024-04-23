class Question{
  String title;
  List<String> candidates;
  int answer;
  int candNum;

  Question({required this.title, required this.candidates, required this.answer, required this.candNum});

  Question.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        candidates = map['candidates'],
        answer = map['answer'],
        candNum = map['candNum'];
}