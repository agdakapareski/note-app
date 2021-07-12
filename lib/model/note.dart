class Note {
  int id;
  String title;
  String description;

  Note(
    this.id,
    this.title,
    this.description,
  );

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
    return json;
  }

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }
}
