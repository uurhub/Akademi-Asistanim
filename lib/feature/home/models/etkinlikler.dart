import 'package:equatable/equatable.dart';

import '../../../base/base_firebase_model.dart';

class Etkinlikler extends Equatable with IdModel, BaseFirebaseModel<Etkinlikler>{
  final String? date;
  final String? description;
  final String? duration;
  final bool? obligation;
  final String? title;
  @override
  final String? id;

  Etkinlikler({
    this.date,
    this.description,
    this.duration,
    this.obligation,
    this.title,
    this.id,
  });

  @override
  List<Object?> get props =>
      [date, description, duration, obligation, title, id];

  Etkinlikler copyWith({
    String? date,
    String? description,
    String? duration,
    bool? obligation,
    String? title,
    String? id,
  }) {
    return Etkinlikler(
        date: date ?? this.date,
        description: description ?? this.description,
        duration: duration ?? this.duration,
        obligation: obligation ?? this.obligation,
        title: title ?? this.title,
        id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'description': description,
      'duration': duration,
      'obligation': obligation,
      'title': title,
      'id': id,
    };
  }

  
  Etkinlikler fromJson(Map<String, dynamic> json) {
    return Etkinlikler(
      date: json['date'] as String?,
      description: json['description'] as String?,
      duration: json['duration'] as String?,
      obligation: json['obligation'] as bool?,
      title: json['title'] as String?,
      id: json['id'] as String?,
    );
  }
}
