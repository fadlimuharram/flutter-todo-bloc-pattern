class Todo {
  int id;
  String description;
  bool isDone;

  Todo({this.id, this.description, this.isDone});

  factory Todo.fromDatabaseJson(Map<String, dynamic> data) {
    // di gunakan untuk menkonversi josn object
    // yang berasal dari query databae dan
    // di konversi ke dalama todo object
    return Todo(
        id: data['id'],
        description: data['description'],
        isDone: data['is_done'] == 0 ? false : true);
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      "id": this.id,
      "description": this.description,
      "is_done": this.isDone == false ? 0 : 1
    };
  }
}
