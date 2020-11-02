import 'package:flutter/material.dart';
import 'package:workload_allocation/Screens/tasking/CreateTask.dart';
import 'package:workload_allocation/Screens/tasking/PlayTask.dart';
import 'package:workload_allocation/Screens/widgets/widgets.dart';
import 'package:workload_allocation/Services/database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream taskStream;
  bool _error = false;
  bool _getStarted = false;
  DatabaseService databaseService = new DatabaseService();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


  Widget taskList(){
    if(_error){
      return Text("Something went wrong");
    }
    if(_getStarted){
      return CircularProgressIndicator();
    }

    return Container(
      child: StreamBuilder(
        stream: taskStream,
          builder: (BuildContext context, snapshot) {
          return snapshot.data == null ? Container():
              ListView.builder(
                itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
                  return TaskTile(
                    taskName:
                    snapshot.data.documents[index].data()["taskName"],
                    dueDate: snapshot.data.documents[index]
                        .data()["dateAssigned"],
                    assignee: snapshot.data.documents[index]
                        .data()["assigned"],
                    taskId: snapshot.data.documents[index].data()["taskID"],
                  );

                  });
      },
      )
    );

  }
  //TODO GET THE DATA FROM FIREBASE AND ASSIGN IT TO THE TASKSTREAM FOR USE ABOVE
  void waitForData() async{
    try{
      setState(() {
        _getStarted = true;
      });
      await databaseService.getTaskData().then((value) {
        setState(() {
          taskStream = value;
          _getStarted = false;
        });


      });

    } catch(e){
      setState(() {
        _error = true;
      });
    }
  }
  @override
  void initState() {
    waitForData();
    super.initState();
    //initUser();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context, "kaziManager", "Tasks"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        centerTitle: true,

      ),
      body: taskList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.brown[400],
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateTask(),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavbar(),
    );
  }



}

class TaskTile extends StatelessWidget {
  final String taskName;

  final String dueDate;
  final String assignee;
  final String taskId;

  TaskTile(
      {this.taskName,
        this.dueDate,
        this.assignee,
        this.taskId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayTask(taskId)));

      },
      child:  Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.brown[400],
        ),
        margin: EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "" + taskName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Assigned: " + assignee,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Due: " + dueDate,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

