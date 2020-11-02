import 'package:flutter/material.dart';
import 'package:workload_allocation/Screens/tasking/AddTodo.dart';
import 'package:workload_allocation/Screens/widgets/widgets.dart';
import 'package:workload_allocation/Services/database.dart';
import 'package:random_string/random_string.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {

  final _formKey = GlobalKey<FormState>();
  String taskName, assigned, createdBy, taskID, status;
  var dateassigned;
  int _assignedTasks = 0;
  int _completedTasks = 0;

  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  //add tasks to firestore db
  createTaskDb() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      taskID = randomAlphaNumeric(16);
      Map<String, String> taskData = {
        "taskID": taskID,
        "taskName": taskName,
        "createdBy": createdBy,
        "assigned": assigned,
        "dateAssigned": dateassigned,
        "status": status
      };
      /*Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddTodo(taskID: taskID)));*/
      await databaseService.addTaskData(taskData, taskID).then((value) {
        setState(() {
          _isLoading = false;
        });

        Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddTodo(taskID: taskID)));
      });
    }
  }

  addAssigneeDetails() async  {
    if(_formKey.currentState.validate()){

      Map<String, String> assigneeData = {
        "taskID": assigned,
        "createdBy": createdBy,
        "assigned_tasks": _assignedTasks.toString(),
        "dateAssigned": dateassigned,
        "completed_tasks": _completedTasks.toString()
      };
      /*Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddTodo(taskID: taskID)));*/
      await databaseService.addAssigneeData(assigneeData, assigned).then((value) {
        setState(() {

        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context, "create", "Task"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _isLoading
          ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ))
          : Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Task Name"),
                  validator: (val) =>
                  val.isEmpty ? "Input Name please" : null,
                  onChanged: (val) {
                    taskName = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  decoration:
                  InputDecoration(hintText: "Task Assignee"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Email is required';
                    }

                    if (!RegExp(
                        "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                        .hasMatch(val)) {
                      return 'Enter a valid email address';
                    }

                  },
                  onChanged: (val) {
                    assigned = val;
                  },
                ),

                SizedBox(
                  height: 6,
                ),
                TextFormField(
                        decoration: InputDecoration(hintText: "Task Creator"),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Email is required';
                          }

                          if (!RegExp(
                                  "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                              .hasMatch(val)) {
                            return 'Enter a valid email address';
                          }

                        },
                        onChanged: (val) {
                          createdBy = val;
                        },
                      ),

                SizedBox(
                  height: 6,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                    child: Column(
                      children: [
                        Text("Task Deadline"),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            //open a date picker
                            showDatePicker(
                              context: context,
                              initialDate: dateassigned == null
                                  ? DateTime.now()
                                  : dateassigned,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2099),
                            ).then((date) {
                              setState(() {
                                dateassigned = date.toString();
                              });
                            });
                          },
                        ),
                      ],
                    )),
                //Spacer(),
                SizedBox(height: 60),
                GestureDetector(
                    onTap: () {
                      //creates a task and moves to the next screen
                      createTaskDb();
                      _assignedTasks += 1;
                      status = "Incomplete";
                      setState(() {

                      });
                      addAssigneeDetails();

                    },
                    child: blueButton(
                        context: context, label: "Create Task")),
                SizedBox(height: 10)
              ],
            )),
      ),
    );
  }
}
