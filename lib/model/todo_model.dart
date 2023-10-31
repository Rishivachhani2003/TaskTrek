import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docID;
  final String titleTask;
  final String description;
  final String category;
  final String dateTask;
  final String timeTask;
  final bool isDone;

  TodoModel({
    this.docID,
    required this.titleTask,
    required this.description,
    required this.category,
    required this.dateTask,
    required this.timeTask,
    required this.isDone,
  });

  toJson() {
    return {
      "titleTask": titleTask,
      "description": description,
      "category": category,
      "dateTask": dateTask,
      "timeTask": timeTask,
      "isDone": false,
    };
  }

  factory TodoModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return TodoModel(
      docID: document.id,
      titleTask: data!['titleTask'],
      description: data['description'],
      category: data['category'],
      dateTask: data['dateTask'],
      timeTask: data['timeTask'],
      isDone: data['isDone'],
    );
  }
}
