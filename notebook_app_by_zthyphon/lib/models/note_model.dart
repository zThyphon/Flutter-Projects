class Note {
  int? id;
  String title;
  String content;
  String date;
  int colorId;

  Note(this.id, this.title, this.content, this.date, this.colorId);

  int getId() {
    return id!;
  }

  String getTitle() {
    return title;
  }

  String getContent() {
    return content;
  }

  String getDate() {
    return date;
  }

  int getColorId() {
    return colorId;
  }

  void setId(int id) {
    this.id = id;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setContent(String content) {
    this.content = content;
  }

  void setDate(String date) {
    this.date = date;
  }

  void setColorId(int colorId) {
    this.colorId = colorId;
  }

  factory Note.fromObject(dynamic obj) {
    return Note(
      obj['id'],
      obj['title'],
      obj['content'],
      obj['date'],
      obj['colorId'],
    );
  }

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "content": content,
      "date": date,
      "colorId": colorId,
    });
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      map['id'],
      map['title'],
      map['content'],
      map['date'],
      map['colorId'],
    );
  }
}
