import 'dart:async';
import 'package:flutter_crud/database/database.dart';
import 'package:flutter_crud/model/Todo.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createTodo(Todo todo) async {
    final db = await dbProvider.database;
    return db.insert(todoTABLE, todo.toDatabaseJson());
  }

  Future<List<Todo>> getTodos({List<String> columns, String query}) async {
    final db = await dbProvider.database;
    print('---');
    print(db);
    print(query);
    print('---');
    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db.query(todoTABLE,
            columns: columns,
            where: "description LIKE ?",
            whereArgs: ["%$query%"]);
      }
    } else {
      result = await db.query(todoTABLE, columns: columns);
    }

    List<Todo> todos = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];
    return todos;
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;
    return await db.update(todoTABLE, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.database;
    return await db.delete(todoTABLE, where: "id = ?", whereArgs: [id]);
  }

  Future deleteAllTodos() async {
    final db = await dbProvider.database;
    return await db.delete(todoTABLE);
  }
}
