import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/bloc/todo_bloc.dart';
import 'package:flutter_crud/model/Todo.dart';
import 'package:flutter_crud/ui/component/CardFloatingBottom.dart';
import 'package:flutter_crud/ui/component/ListTodo.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  final TodoBloc todoBloc = TodoBloc();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Container(
            child: ListTodo(
              todoBloc: todoBloc,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: CardFloatingBottom(
          color: Colors.white,
          icon: Icon(
            Icons.add,
            size: 32,
            color: Colors.indigoAccent,
          ),
          onPressed: () {
            print('hii');
            _showAddTodoSheet(context);
          },
        ),
      ),
    );
  }

  void _showAddTodoSheet(BuildContext context) {
    final _todoDescriptionFromController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: 230,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
            child: Padding(
                padding: EdgeInsets.only(
                  left: 15.0,
                  top: 25.0,
                  right: 15.0,
                  bottom: 30.0,
                ),
                child: ListView(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoDescriptionFromController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w400,
                              ),
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: 'Tugas Saya',
                                labelText: 'Todo Baru',
                                labelStyle: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Empty description';
                                }

                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    final newTodo = Todo(
                                        description:
                                            _todoDescriptionFromController
                                                .value.text);
                                    todoBloc.addTodo(newTodo);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  dispose() {
    todoBloc.dispose();
  }
}
