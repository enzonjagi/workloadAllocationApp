import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Tasks collection
  Future<void> addTaskData(Map taskData, String taskID) async {
    await firestore
        .collection("Task")
        .doc(taskID)
        .set(taskData)
        .catchError((e) {
      print(e.toString());
    });
  }
  //todo-items subcollection
  Future<void> addTodoItems(Map todoData, String taskID)async{
    await firestore
        .collection("Task")
        .doc(taskID)
        .collection("TodoItem")
        .add(todoData)
        .catchError((e) {
      print(e.toString());
    });
  }
  //Post to-do items complete

  //GET TASK LIST DATA
  Future getTaskData() async{
    return firestore
        .collection("Task")
        .snapshots(includeMetadataChanges:  true);
  }

  //GET INDIVIDUAL TASK DATA
  //
  Future getOneTaskData(String taskId) async{

    return await firestore
        .collection("Task")
        .doc(taskId)
        .collection("TodoItem")
        .get();

  }

  //COMPLETED TASKS
  Future<void> addCompletedTasksData(Map taskData, String taskID) async {
    await firestore
        .collection("Completed Tasks")
        .doc(taskID)
        .set(taskData)
        .catchError((e) {
      print(e.toString());
    });
  }

  //Tracking
  Future<void> addAssigneeData(Map taskData, String taskID) async {
    await firestore
        .collection("Tracking")
        .doc(taskID)
        .set(taskData)
        .catchError((e) {
      print(e.toString());
    });
  }
  Future getAssigneeData() async{
    return firestore
        .collection("Tracking")
        .snapshots(includeMetadataChanges:  true);
  }
  ///todo
  ///Task reports collection
  ///add tracking for todoItems; assigned, completed, total
  ///add tracking for;
  /// users; collection
  /// user tasks; sub collection(assigned tasks, completed tasks, deadlines met)


}