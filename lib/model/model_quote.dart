class Quote{
  String content;

  Quote({required this.content});

  Quote.fromMap(Map<String, dynamic> map)
    : content = map['content'];
}