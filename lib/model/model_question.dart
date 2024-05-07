class Question{
  int qID;
  String title;
  List<String> candidates;
  bool rating;
  int candNum;

  Question({required this.qID,required this.title, required this.candidates, required this.rating, required this.candNum});

  Question.fromMap(Map<String, dynamic> map)
    : qID = map['qID'],
      title = map['title'],
      candidates = map['candidates'],
      rating = map['rating'],
      candNum = map['candNum'];
}