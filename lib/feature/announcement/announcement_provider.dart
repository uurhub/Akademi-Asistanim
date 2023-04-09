import 'package:equatable/equatable.dart';
import 'package:f_44_oua/base/firebase_collections.dart';
import 'package:f_44_oua/feature/home/models/duyurular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnnouncementNotifier extends StateNotifier<AnnouncementState> {
  AnnouncementNotifier(): super(const AnnouncementState());
  List<Duyurular> _fullDuyurularList = [];
  List<Duyurular> get fullDuyurularList => _fullDuyurularList;

  Future<void> fetchAnnouncements() async {
    final duyurularCollectionReference = FirebaseCollections.duyurular.reference;

    final response = await duyurularCollectionReference.withConverter<Duyurular>(fromFirestore: (snapshot, options) {
      return Duyurular().fromFirebase(snapshot);
    }, toFirestore: (value, options) {
      return value.toJson();
    },).get();
    if(response.docs.isNotEmpty){
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(duyurular: values);
    }
  }

  Future<void> fetchAndLoad () async {
    await Future.wait([fetchAnnouncements()]);
  }
}

class AnnouncementState extends Equatable {
  const AnnouncementState({this.duyurular,});

  final List<Duyurular>? duyurular;

  @override
  List<Object?> get props => [duyurular];

  AnnouncementState copyWith({
    List<Duyurular>? duyurular,
  }){
        return AnnouncementState(duyurular: duyurular ?? this.duyurular);
  }

}