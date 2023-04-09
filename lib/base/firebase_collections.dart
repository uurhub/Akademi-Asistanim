import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  etkinlikler,
  duyurular;
  

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
