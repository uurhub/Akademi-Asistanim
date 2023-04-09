import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/firebase_collections.dart';
import '../home/models/etkinlikler.dart';

class EventsNotifier extends StateNotifier<EventsState> {
  EventsNotifier() : super(const EventsState());

  List<Etkinlikler> _fullEtkinliklerList = [];
  List<Etkinlikler> get fullEtkinliklerList => _fullEtkinliklerList;

  Future<void> fetchEvents() async {
    final etkinlikerCollectionReference = FirebaseCollections.etkinlikler.reference;

    final response = await etkinlikerCollectionReference.withConverter<Etkinlikler>(fromFirestore: (snapshot, options) {
      return Etkinlikler().fromFirebase(snapshot);
    }, toFirestore: (value, options) {
      return value.toJson();
    },).get();
    if(response.docs.isNotEmpty){
      final values = response.docs.map((e)=>e.data()).toList();
      state = state.copyWith(etkinlikler: values);
    }
  }

  Future<void> fetchAndLoad () async {
    await Future.wait([fetchEvents()]);
  }
}

class EventsState extends Equatable {
  const EventsState({
    this.etkinlikler,
  });

  final List<Etkinlikler>? etkinlikler;

  @override
  List<Object?> get props => [etkinlikler];

  EventsState copyWith({
    List<Etkinlikler>? etkinlikler,
  }) {
    return EventsState(etkinlikler: etkinlikler ?? this.etkinlikler);
  }
}
