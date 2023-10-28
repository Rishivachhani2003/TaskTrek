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


//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};
//     result.addAll({'titleTask': titleTask});
//     result.addAll({'description': description});
//     result.addAll({'category': category});
//     result.addAll({'dateTask': dateTask});
//     result.addAll({'timeTask': timeTask});
//     result.addAll({'isDone': isDone});

//     return result;
//   }

//   factory TodoModel.fromMap(Map<String, dynamic> map) {
//     return TodoModel(
//       docID: map['docID'],
//       titleTask: map['titleTask'] ?? '',
//       description: map['description'] ?? '',
//       category: map['category'] ?? '',
//       dateTask: map['dateTask'] ?? '',
//       timeTask: map['timeTask'] ?? '',
//       isDone: map['isDone'] ?? false,
//     );
//   }

//   // String toJson() => json.encode(toMap());

//   // factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source));

//   factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
//     return TodoModel(
//         docID: doc.id,
//         titleTask: doc['titleTask'],
//         description: doc['description'],
//         category: doc['category'],
//         dateTask: doc['dateTask'],
//         timeTask: doc['timeTask'],
//         isDone: doc['isDone']);
//   }
// }
