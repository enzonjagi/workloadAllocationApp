import 'package:flutter/material.dart';
import 'package:workload_allocation/Screens/Home/home.dart';
import 'package:workload_allocation/Screens/reports/taskingReport.dart';

Widget appBar(BuildContext context, String first, String second) {
  return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 22),
        children: <TextSpan>[
          TextSpan(
              text: first,
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54)),
          TextSpan(
              text: second,
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.brown)),
        ],
      ));
}
Widget blueButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
        color: Colors.brown, borderRadius: BorderRadius.circular(30)),
    alignment: Alignment.center,
    width: buttonWidth != null
        ? buttonWidth
        : MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

class BottomNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),

      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
          Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 5),
                Text(
                  "Tasks",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )

              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ReportTableWidget()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.description),
                SizedBox(width: 5),
                Text(
                  "Tracking",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        /*IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            })*/
      ]),
    );
  }
}