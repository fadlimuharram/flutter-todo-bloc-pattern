import 'package:flutter/material.dart';
import 'package:flutter_crud/bloc/todo_bloc.dart';
import 'package:flutter_crud/model/Todo.dart';

class ListTodo extends StatelessWidget {
  ListTodo({@required this.todoBloc});

  final TodoBloc todoBloc;
  final DismissDirection _dismissDirection = DismissDirection.horizontal;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: todoBloc.todos,
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        return getTodoCardWidget(snapshot);
      },
    );
  }

  Widget getTodoCardWidget(AsyncSnapshot<List<Todo>> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                Todo todo = snapshot.data[itemPosition];
                final Widget dismissibleCard = new Dismissible(
                  background: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Deleting",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  onDismissed: (direction) {
                    todoBloc.deleteTodoById(todo.id);
                  },
                  direction: _dismissDirection,
                  key: new ObjectKey(todo),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey[200],
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        todo.description,
                        style: TextStyle(
                          fontSize: 16.5,
                          fontFamily: 'RobotoMono',
                          fontWeight: FontWeight.w500,
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      leading: InkWell(
                        onTap: () {
                          todo.isDone = !todo.isDone;

                          todoBloc.updateTodo(todo);
                        },
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: todo.isDone
                                ? Icon(
                                    Icons.done,
                                    size: 26,
                                    color: Colors.indigoAccent,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    size: 26.0,
                                    color: Colors.tealAccent,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );

                return dismissibleCard;
              },
            )
          : Container(
              child: Center(
                child: noTodoMessageWidget(),
              ),
            );
    } else {
      return Center(
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    todoBloc.getTodos();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CircularProgressIndicator(), Text("Loading...")],
        ),
      ),
    );
  }

  Widget noTodoMessageWidget() {
    return Container(
      child: Center(
        child: Text(
          "Tambahkan Todo",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
