import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scbassignment/assets/app_colors.dart';
import 'dart:convert';
import '../../views/passcode/passcode.dart';
import '../../views/tab/tab.dart';
import 'model/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status = 'TODO';
  List<Task> todoTask = [];
  List<Task> doingTask = [];
  List<Task> doneTask = [];

  int currentPage = 0;
  int itemsPerPage = 10;
  bool isLoading = false;
  bool isError = false;

  late Timer _timer;
  int _inactiveSeconds = 0;

  @override
  void initState() {
    super.initState();

    fetchItems(status, true);
    startTimer();
  }

  void startTimer() {
    resetTimer();

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_inactiveSeconds >= 10) {
        // Lock the app after 10 seconds of inactivity
        timer.cancel();
        _showPasscodePopup(context);
      } else {
        _inactiveSeconds++;
      }
    });
  }

  void resetTimer() {
    _inactiveSeconds = 0;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchItems(
      final String status, final bool shouldShowPasscodePopup) async {
    todoTask.clear();
    doingTask.clear();
    doneTask.clear();

    currentPage = 0;

    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        String url =
            'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=$currentPage&limit=$itemsPerPage&sortBy=createdAt&isAsc=true&status=$status';

        final response = await http.get(
          Uri.parse(url),
        );

        if (response.statusCode == 200 && response.body.isNotEmpty) {
          final jsonData = json.decode(response.body);

          _checkJsonDataIfNotEmpty(jsonData);
        } else {
          _showErrorPopup(context);
        }
      } catch (error) {
        _showErrorPopup(context);
      }

      setState(() {
        isLoading = false;
      });

      if (shouldShowPasscodePopup) {
        _showPasscodePopup(context);
      }
    }
  }

  void _checkJsonDataIfNotEmpty(jsonData) {
    if (jsonData.isNotEmpty) {
      final todo = TodoList.fromJson(jsonData);
      final taskItems = todo.tasks;

      _checkTaskIfNotEmpty(taskItems);
    } else {
      _showErrorPopup(context);
    }
  }

  void _checkTaskIfNotEmpty(List<Task> taskItems) {
    if (taskItems.isNotEmpty) {
      setState(() {
        if (taskItems.isNotEmpty) {
          _updateTask(taskItems);
        }
      });
    } else {
      _showErrorPopup(context);
    }
  }

  void _updateTask(List<Task> taskItems) {
    switch (status) {
      case 'DONE':
        doneTask.addAll(taskItems);
        break;
      case 'DOING':
        doingTask.addAll(taskItems);
        break;
      default:
        todoTask.addAll(taskItems);
        break;
    }

    currentPage++;
  }

  void _showErrorPopup(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Something went wrong!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPasscodePopup(BuildContext context) {
    _timer.cancel();

    showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return PasscodeLockScreen(onDismissDialog: startTimer);
        });
  }

  void _handleTabTap(int index) {
    switch (index) {
      case 1:
        status = 'DOING';
        break;
      case 2:
        status = 'DONE';
        break;
      default:
        status = 'TODO';
        break;
    }

    fetchItems(status, false);
  }

  void _handleTodoTaskPressed(int index) {
    setState(() {
      todoTask.removeAt(index);
    });
  }

  void _handleDoingTaskPressed(int index) {
    setState(() {
      doingTask.removeAt(index);
    });
  }

  void _handleDoneTaskPressed(int index) {
    setState(() {
      doneTask.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightGrey,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              const Text(
                'Hi! User',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'This is just sample UI.\nOpen to create your style :D',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3, // Number of tabs
                  child: MyTabbedPage(
                      handleTabTap: _handleTabTap,
                      todoTask: todoTask,
                      doingTask: doingTask,
                      doneTask: doneTask,
                      handleTodoTaskPressed: _handleTodoTaskPressed,
                      handleDoingTaskPressed: _handleDoingTaskPressed,
                      handleDoneTaskPressed: _handleDoneTaskPressed),
                ),
              ),
            ],
          ),
        ));
  }
}
