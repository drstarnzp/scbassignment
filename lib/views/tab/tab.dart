import 'package:flutter/material.dart';

import '../../assets/app_colors.dart';
import '../../feature/model/task.dart';

class MyTabbedPage extends StatefulWidget {
  final Function(int) handleTabTap;
  final Function(int) handleTodoTaskPressed;
  final Function(int) handleDoingTaskPressed;
  final Function(int) handleDoneTaskPressed;

  final List<Task> todoTask;
  final List<Task> doingTask;
  final List<Task> doneTask;

  const MyTabbedPage(
      {super.key,
      required this.handleTabTap,
      required this.todoTask,
      required this.doingTask,
      required this.doneTask,
      required this.handleDoingTaskPressed,
      required this.handleDoneTaskPressed,
      required this.handleTodoTaskPressed});

  @override
  _MyTabbedPage createState() => _MyTabbedPage();
}

class _MyTabbedPage extends State<MyTabbedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Column(
        children: [
          buildTabBar(),
          Expanded(
            child: TabBarView(
              children: [buildTap1(), buildTap2(), buildTap3()],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      color: Colors.transparent,
      child: TabBar(
        tabs: const [
          Tab(
            text: 'To-do',
          ),
          Tab(text: 'Doing'),
          Tab(text: 'Done'),
        ],
        onTap: widget.handleTabTap,
      ),
    );
  }

  Widget buildTap1() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.todoTask.length,
        itemBuilder: (context, index) {
          if (widget.todoTask.isNotEmpty) {
            return Column(children: [
              ListTile(
                title: Text(
                  widget.todoTask[index].title ?? '',
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Text(widget.todoTask[index].description ?? ''),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      widget.handleTodoTaskPressed(index);
                    }),
              ),
            ]);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildTap2() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.doingTask.length,
        itemBuilder: (context, index) {
          if (widget.doingTask.isNotEmpty) {
            return Column(children: [
              ListTile(
                title: Text(
                  widget.doingTask[index].title ?? '',
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Text(widget.doingTask[index].description ?? ''),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.handleDoingTaskPressed(index);
                  },
                ),
              ),
            ]);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildTap3() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.doneTask.length,
        itemBuilder: (context, index) {
          if (widget.doneTask.isNotEmpty) {
            return Column(children: [
              ListTile(
                title: Text(
                  widget.doneTask[index].title ?? '',
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Text(widget.doneTask[index].description ?? ''),
                trailing: IconButton(
                  alignment: Alignment.topRight,
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      widget.handleDoneTaskPressed(index);
                    }),
              ),
            ]);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
