class Question{
  String title;
  List<String> candidates;
  int ansCand;
  String ansStr;
  bool rating;
  int candNum;

  Question({required this.title, required this.candidates, required this.rating, required this.ansCand, required this.ansStr, required this.candNum});

  Question.fromMap(Map<String, dynamic> map)
    : title = map['title'],
      candidates = map['candidates'],
      ansCand = map['ansCand'],
      ansStr = map['ansStr'],
      rating = map['rating'],
      candNum = map['candNum'];
}