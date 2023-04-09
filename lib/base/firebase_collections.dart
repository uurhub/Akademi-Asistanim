import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  etkinlikler;
  

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
