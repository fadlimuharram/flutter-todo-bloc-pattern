import 'package:flutter_crud/model/Todo.dart';
import 'package:flutter_crud/repository/todo_repository.dart';

import 'dart:async';

class TodoBloc {
  final _todoRepository = TodoRepository();

  // stream contorller adalah yang melakukan
  // management data seperti
  // tambah data, perubahan state dari stream
  // dan melakukan broadcast ke observer/subscriber
  final _todoController = StreamController<List<Todo>>.broadcast();

  get todos => _todoController.stream;

  TodoBloc() {
    getTodos();
  }

  getTodos({String query}) async {
    // sink merupakan cara reactively untuk melakukan stream dengan
    // register event baru
    _todoController.sink.add(await _todoRepository.getAllTodos(query: query));
  }

  addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
    getTodos();
  }

  updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    getTodos();
  }

  deleteTodoById(int id) async {
    _todoRepository.deleteTodoById(id);
    getTodos();
  }

  dispose() {
    _todoController.close();
  }
}
