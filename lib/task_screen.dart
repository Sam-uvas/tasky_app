import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  final String userName;

  TaskScreen({required this.userName});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];
  bool isFabOpen = false;
  TextEditingController taskController = TextEditingController();

  void toggleFab() {
    setState(() {
      isFabOpen = !isFabOpen;
    });
  }

  void addTask(String taskName) {
    setState(() {
      tasks.add(Task(name: taskName));
    });
    taskController.clear();
  }

  void editTask(int index, String newName) {
    setState(() {
      tasks[index].name = newName;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalTasks = tasks.length;
    int completedTasks = tasks.where((task) => task.isCompleted).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, ${widget.userName} 👋'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEE, MMM d').format(DateTime.now()),
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('Total Tasks', '$totalTasks'),
                _buildStatCard('Completed Tasks', '$completedTasks'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Tasks of the Day',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(tasks[index].name),
                    onDismissed: (direction) {
                      deleteTask(index);
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: AlignmentDirectional.centerStart,
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: _buildTaskItem(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isFabOpen ? _buildFabExpand() : _buildFabCollapse(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.indigo[900],
        unselectedItemColor: Colors.indigo[900],
        onTap: (index) {},
      ),
    );
  }

  Widget _buildStatCard(String title, String count) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(count, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: ListTile(
        title: TextField(
          controller: TextEditingController(text: tasks[index].name),
          decoration: InputDecoration(border: InputBorder.none),
          onSubmitted: (newName) {
            editTask(index, newName);
          },
        ),
        trailing: Checkbox(
          value: tasks[index].isCompleted,
          onChanged: (bool? value) {
            toggleTaskCompletion(index);
          },
        ),
      ),
    );
  }

  Widget _buildFabExpand() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Add Task'),
                  content: TextField(
                    controller: taskController,
                    decoration: InputDecoration(hintText: 'Enter task name'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        addTask(taskController.text);
                        Navigator.of(context).pop();
                      },
                      child: Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.task_alt),
          label: Text('Create Task'),
        ),
        SizedBox(height: 8),
        FloatingActionButton(
          onPressed: toggleFab,
          child: Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildFabCollapse() {
    return FloatingActionButton(
      onPressed: toggleFab,
      child: Icon(Icons.add),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
