import 'package:flutter/material.dart';
import 'package:workload_allocation/Screens/widgets/widgets.dart';

class TaskReport extends StatefulWidget {
  @override
  _TaskReportState createState() => _TaskReportState();
}

class _TaskReportState extends State<TaskReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context, "task", "Report"),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
          centerTitle: true
      ),
    );
  }
}

class TaskReportCard extends StatefulWidget {
  @override
  _TaskReportCardState createState() => _TaskReportCardState();
}

class _TaskReportCardState extends State<TaskReportCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text("TaskName"),
                SizedBox(width: 5,),
                Text("Add task Name here")
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Date Completed"),
                SizedBox(width: 5,),
                Text("Add here")
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Todo items completed"),
                SizedBox(width: 5,),
                Text("Add here")
              ],
            ),
            SizedBox(height: 10,),
            Spacer(),
            GestureDetector(
                onTap: (){

            },
                child: blueButton(context: context, label: "Verify")),
          ],
        ),
      ),
    );
  }
}

