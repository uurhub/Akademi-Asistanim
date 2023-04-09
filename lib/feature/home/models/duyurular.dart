import 'package:equatable/equatable.dart';

import '../../../base/base_firebase_model.dart';

class Duyurular extends Equatable with IdModel, BaseFirebaseModel<Duyurular> {
  final String? description;
  final String? date;
  @override
  final String? id;

  Duyurular({
    this.description,
    this.date,
    this.id,
  });

  @override
  List<Object?> get props => [description, date, id];

  Duyurular copyWith({
    String? description,
    String? date,
    String? id,
  }) {
    return Duyurular(
      description: description ?? this.description,
      date: date ?? this.date,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'date': date,
    };
  }

  Duyurular fromJson(Map<String, dynamic> json) {
    return Duyurular(
      description: json['description'] as String?,
      date: json['date'] as String?,
      id: json['id'] as String?,
    );
  }
}
