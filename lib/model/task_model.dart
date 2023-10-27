import 'package:todo_app/core/utils/extract_date.dart';

class TaskModel {
  String? id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  TaskModel(
      {this.id,
      required this.title,
      required this.description,
      required this.dateTime,
      required this.isDone});

//from FireStore

  factory TaskModel.fromFireStore(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(json["dateTime"]),
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dateTime": ExtractDate.extractDate(dateTime).millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }
}
