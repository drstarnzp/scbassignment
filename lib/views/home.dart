import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> tabs = ['To-do', 'Doing', 'Done'];

  List<Task> tasks = [];
  String status = 'TODO';
  int selectedIndex = 0;

  int currentPage = 0;
  int itemsPerPage = 10;
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();

    fetchItems(status);
  }

  Future<void> fetchItems(final String status) async {
    tasks.clear();
    currentPage = 0;

    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      String url =
          'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=$currentPage&limit=$itemsPerPage&sortBy=createdAt&isAsc=true&status=$status';

      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final jsonData = json.decode(response.body);

        if (jsonData.isNotEmpty) {
          final todo = TodoList.fromJson(jsonData);
          final taskItems = todo.tasks;

          if (taskItems.isNotEmpty) {
            setState(() {
              if (taskItems.isNotEmpty) {
                tasks.addAll(taskItems);
                currentPage++;
              }
            });
          } else {
            _showPopup(context);
          }
        }
      } else {
        _showPopup(context);
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const SafeArea(child: Center(child: CircularProgressIndicator()))
            : SafeArea(
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 16,left: 16, right: 16),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'This is just sample UI.\nOpen to create your style :D',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                        height: 200,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: tabs.length,
                          padding: EdgeInsets.all(16),
                          itemBuilder: (BuildContext context, int index) {
                            bool isSelected = index == selectedIndex;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = isSelected ? 0 : index;

                                  switch (selectedIndex) {
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

                                  fetchItems(status);
                                });
                              },
                              child: Container(
                                child: Card(
                                  color:
                                      isSelected ? Colors.blue : Colors.white,
                                  child: Center(
                                    child: Text(
                                      tabs[index],
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                    Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          if (tasks.isNotEmpty) {
                            return Column(children: [
                              ListTile(
                                title: Text(
                                  tasks[index].title ?? '',
                                  style: const TextStyle(fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                subtitle: Text(tasks[index].description ?? ''),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Remove the task from the list
                                    setState(() {
                                      tasks.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ]);
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }
}
