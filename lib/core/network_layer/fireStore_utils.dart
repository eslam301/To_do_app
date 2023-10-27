import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task_model.dart';

class FireStoreUtils {
  static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection("TasksCollection")
        .withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromFireStore(snapshot.data()!),
            toFirestore: (value, _) => value.toFireStore());
  }

  static Future<void> addDataToFIreStore(TaskModel model) async {
    var collectionRef = getCollection();
    var docRef = collectionRef.doc();
    model.id = docRef.id;
    docRef.set(model);
  }

  static Future<void> deleteDataFromFireStore(TaskModel model) async {
    var collectionRef = getCollection();
    collectionRef.doc(model.id).delete();
  }

  static Future<List<TaskModel>> getDataFromFireStore() async {
    var snapshot = await getCollection().get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDataFromFireStore() {
    var snapshot = getCollection().snapshots();
    return snapshot;
  }
}
