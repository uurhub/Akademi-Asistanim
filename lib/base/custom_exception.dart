import 'package:firebase_core/firebase_core.dart';

class FirebaseCustomException implements Exception {
  FirebaseCustomException(this.description);
  final String description;
  @override
  String toString() {
    return '$this $description';
  }
}

class VersionCustomException implements Exception {
  VersionCustomException(this.description);
  final String description;
  @override
  String toString() {
    return '$this $description';
  }
}
