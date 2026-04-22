import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/content_model.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Stream<List<ContentModel>> getContents() {
    return _db.collection('contents').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ContentModel.fromMap(doc.data()))
          .toList();
    });
  }
}