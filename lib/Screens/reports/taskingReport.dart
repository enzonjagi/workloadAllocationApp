import 'package:flutter/material.dart';
import 'package:workload_allocation/Screens/widgets/widgets.dart';
import 'package:workload_allocation/Services/database.dart';
//TODO USE A DATA TABLE HERE


class ReportTableWidget extends StatefulWidget {
  const ReportTableWidget({Key key}) : super(key: key);

  @override
  _ReportTableWidgetState createState() => _ReportTableWidgetState();
}

class _ReportTableWidgetState extends State<ReportTableWidget> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage ;
  Stream taskingStream;
  bool _error = false;
  bool _getStarted = false;
  DatabaseService databaseService = new DatabaseService();


  @override
  void initState() {
    //waitForData();
    super.initState();
    //initUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context, "tasking", " Reports"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.brown[800],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: PaginatedDataTable(
            header: Text("User Tasking"),
            rowsPerPage: _rowsPerPage,
            columns: kTableColumns,
            source: UserDataSource(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}

//Columns in the table
const kTableColumns = <DataColumn>[
  DataColumn(label: Text("User")),
  DataColumn(label: Text("Tasks Assigned"), numeric: true),
  DataColumn(label: Text("Tasks Completed"), numeric: true),
  DataColumn(label: Text("Deadlines met"), numeric: true)
];



//Data class
class ReportInfo {
  ReportInfo(this.name, this.assigned, this.completed, this.deadlines);

  String name;
  int assigned;
  int completed;
  int deadlines;
  bool _selected = false;
}

//The Source of the user data
class UserDataSource extends DataTableSource {
  int _assigned = 0;
  int _completed = 0;
  int deadlines = 0;
  int _selectedCount = 0;
  /*Stream taskingStream;
  bool _error = false;
  bool _getStarted = false;
  DatabaseService databaseService = new DatabaseService();
  UserReports(){
    if(_error){
      return Text("Something went wrong");
    }
    if(_getStarted){
      return CircularProgressIndicator();
    }

    ReportInfo getAssigneeDetails(context, snapshot){
      ReportInfo reportInfo = new ReportInfo();

      reportInfo.name = snapshot.data()["taskID"];
      reportInfo.assigned = snapshot.data()["assigned_Tasks"];
      reportInfo.completed = snapshot.data()["completed_Tasks"];
      reportInfo.deadlines = 0;

      return reportInfo;
    }
  }

  void waitForData() async{
    try{
      /*setState(() {
        _getStarted = true;
      });*/
      await databaseService.getAssigneeData().then((value) {
        //setState(() {
          taskingStream = value;
          _getStarted = false;
        //});


      });

    } catch(e){
      //setState(() {
        _error = true;
      //});
    }
  }*/

  final List<ReportInfo> _userReports = <ReportInfo> [
    new ReportInfo('amosndungo@gmail.com', 2, 0, 0),
    new ReportInfo('omarnjagi@gmail.com', 0, 0, 0),
    new ReportInfo('enzonjagi@gmail.com', 0, 0, 0),

  ];



  @override
  DataRow getRow(int index) {

    assert(index >= 0);
    if(index >= _userReports.length) return null;
    final ReportInfo reportInfo = _userReports[index];
    return DataRow.byIndex(
        index: index,
        selected: reportInfo._selected,
        onSelectChanged: (bool value){
          if (reportInfo._selected != value){
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            reportInfo._selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text("${reportInfo.name}")),
          DataCell(Text("${reportInfo.assigned}")),
          DataCell(Text("${reportInfo.completed}")),
          DataCell(Text("${reportInfo.deadlines}")),
        ]
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _userReports.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => _selectedCount;}

