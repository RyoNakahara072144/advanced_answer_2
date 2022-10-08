
//問１　本の情報を持つBookモデルの定義
class Book{
  Book({
    required this.title,
    required this.author,
    required this.date,
  });

  Book.fromJson(Map<String, Object?> json)
      : this(
    title: json['title']! as String,
    author: json['author']! as String,
    date: json['date']! as int,
  );

  final String title;
  final String author;
  final int date;

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'author': author,
      'date': date,
    };
  }
}