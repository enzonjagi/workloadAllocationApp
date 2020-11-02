import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workload_allocation/Models/todoParts.dart';
import 'package:workload_allocation/Screens/widgets/taskWidget.dart';
import 'package:workload_allocation/Screens/widgets/widgets.dart';
import 'package:workload_allocation/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlayTask extends StatefulWidget {
  final String taskId;

  PlayTask(this.taskId);

  @override
  _PlayTaskState createState() => _PlayTaskState();
}

int _totalTodos = 0;
int _attempted = 0;
int _notAttempted = 0;
double _progressValue = 0;

class _PlayTaskState extends State<PlayTask> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot todoSnapshot;
  String taskName, taskDescription, taskAssignee, taskId, dateAssigned;
  //get the task name for the taskbar
  getTaskName() {}

  //save progress
  saveTodoProgress() {}

  //complete task
  //and save it to the report collection
  saveToTaskToReportCollection() {}

  //get data from subcollection within the task document
  TodopartsModel getTaskModelDataFromDocSnapshot(
      DocumentSnapshot taskSnapshot) {
    TodopartsModel todopartsModel = new TodopartsModel();

    //get todoName and description and assign to the todo parts model
    //todo name
    todopartsModel.todoName = taskSnapshot.data()["todoName"];

    //Todo description
    todopartsModel.todoDesc = taskSnapshot.data()["todoDesc"];

    //initiate todo status to
    todopartsModel.completed = false;

    return todopartsModel;
  }

  void getdata() async {
    await databaseService.getOneTaskData(widget.taskId).then((value) {
      todoSnapshot = value;
      _totalTodos = todoSnapshot.docs.length;
      _attempted = 0;
      _notAttempted = todoSnapshot.docs.length;
      setState(() {
        //update toDo's completed
      });
    });
  }
  addToCompletedCollection() async {

    //TODO UPDATE DB FIELD FOR THE TASK WITH A STATUS "COMPLETE"
    Map<String, String> completedTaskData = {
      "totalTodos": _totalTodos.toString(),
      "completed": _attempted.toString(),
      "incomplete": _notAttempted.toString(),
      "taskref": taskId,

    };

    await databaseService.addCompletedTasksData(completedTaskData, taskId).then((value){
      setState(() {

      });

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context, "Task", "Guide"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.brown[800],
        ),
        centerTitle: true,
      ),
      body: Container(
          child: Column(children: [
            todoSnapshot == null
                ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
                : Container(
              child: Center(
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Total To-dos: $_totalTodos"),
                        SizedBox(width: 10,),
                        Text("Completed: $_attempted"),
                        SizedBox(width: 10,),
                        Text("Not attempted: $_notAttempted"),
                        //SizedBox(width: 10,)
                      ],
                    ),
                    SizedBox(height: 15),
                    Card(
                      child: ListView.builder(
                          padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: todoSnapshot.docs.length,
                          itemBuilder: (context, index) {
                            return PlayTile(
                                todopartsModel: getTaskModelDataFromDocSnapshot(
                                    todoSnapshot.docs[index]),
                                index: index);
                          }),
                    ),
                  ],
                ),
              ),
            )
          ])),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done ),
        backgroundColor: Colors.brown[400],
        onPressed: () {
          addToCompletedCollection();

          //TODO mark the task as complete and add it to the completed tasks counter
          Navigator.pop(context);

        },
      ),
    );
  }
}

class PlayTile extends StatefulWidget {
  //initialize the task model
  final TodopartsModel todopartsModel;
  final int index;
  PlayTile({this.todopartsModel, this.index});
  @override
  _PlayTileState createState() => _PlayTileState();
}

class _PlayTileState extends State<PlayTile> {
  String todoChecked = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //final String todoName, todoDesc, toDoSelected;
            GestureDetector(
              onTap: () {
                if (!widget.todopartsModel.completed) {
                  todoChecked = widget.todopartsModel.todoName;
                  widget.todopartsModel.completed = true;


                  setState(() {
                    //return _progressValue;
                    _attempted = _attempted + 1;
                    _notAttempted = _notAttempted - 1;
                    _progressValue = ((_attempted / _totalTodos) * 100);
                  });
                }
              },
              child: TodoTile(
                todoName: widget.todopartsModel.todoName,
                toDoSelected: todoChecked,
              ),
            ),
            SizedBox(height: 14),
            Text(
              "${widget.todopartsModel.todoDesc}",
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
            SizedBox(height: 22),
          ],
        ));
  }
}

/*

            SizedBox(height: 10,),
 */


/*
 ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.work),
                    onPressed: () {


                    },
                  ),
                  title: Text("${widget.todopartsModel.todoName}"),
                  subtitle: Text("${widget.todopartsModel.todoDesc}"),
                ),
 */





