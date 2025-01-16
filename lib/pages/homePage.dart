import 'package:flutter/material.dart';
import '/todo/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List toDoList = [
    ['Solve Leetcode', true],
    ['Learn Flutter', true],
    ['Drink Coffee', false],
    ['Explore Machine Learning Algorithms', false],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        toDoList.add([_controller.text, false]);
        _controller.clear();
      }
    });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: const Text('To-Do'),
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (BuildContext context, int index) {
                return TodoList(
                  taskName: toDoList[index][0],
                  taskCompleted: toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      filled: true,
                      fillColor: Colors.green.shade200,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                IconButton(
                  onPressed: saveNewTask,
                  icon: const Icon(Icons.add),
                  color: Colors.blue,
                  iconSize: screenWidth * 0.08,
                  constraints: BoxConstraints(
                    maxWidth: screenWidth * 0.12,
                    maxHeight: screenWidth * 0.12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
