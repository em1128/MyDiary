class Answer{
  int qID;
  int ansCand;
  String ansStr;
  

  Answer({required this.qID, required this.ansCand, required this.ansStr});

  Answer.fromMap(Map<String, dynamic> map):
    qID = map['qID'],
    ansCand = map['ansCand'],
    ansStr = map['ansStr'];

  addAnswer(int? cand, String? str){
    ansCand = cand!;
    ansStr = str!;
  }
  
}