import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_44_oua/feature/events/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _eventsProvider =
    StateNotifierProvider<EventsNotifier, EventsState>((ref) {
  return EventsNotifier();
});

class EventsView extends ConsumerStatefulWidget {
  const EventsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventsViewState();
}

class _EventsViewState extends ConsumerState<EventsView> {
  final List<String> months = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(_eventsProvider.notifier).fetchAndLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _eventAkademi(months);
  }
}

class _eventAkademi extends ConsumerWidget {
  const _eventAkademi(this.months, {super.key});
  final List<String> months;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentMonth = 0;
    final eventsItems = ref.watch(_eventsProvider).etkinlikler ?? [];

    final eventsByMonth = List.generate(12, (index) => []);

    
    for (var event in eventsItems) {
      DateTime date = DateTime.parse(event.date.toString());
      final eventMonth = date.month;
      eventsByMonth[eventMonth - 1].add(event);
    }
    for (var monthEvents in eventsByMonth) {
      monthEvents.sort((a, b) => a.date.compareTo(b.date));
    }
    
    var indexcount = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Etkinlikler'),
        backgroundColor: Color(0xffF4B400),
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 12,
          itemBuilder: (context, index) {
            currentMonth = index;
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Chip(
                    label: Container(
                        width: 100,
                        child: Center(
                            child: Text(
                          months[index],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ))),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: eventsByMonth[index].length,
                  itemBuilder: (context, innerindex) {
                    final newdate = DateTime.parse(
                        eventsByMonth[index][innerindex].date.toString());
                    
                    indexcount++;
                    final dur = eventsByMonth[index][innerindex].duration;
                    
                      
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: (indexcount) % 3 == 0
                              ? Color(0xff0F9D58)
                              : (indexcount) % 2 == 0
                                  ? Color(0xff4285F4)
                                  : Color(0xffDB4437),
                        ),
                        height: 170.0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                      backgroundColor:
                                          eventsByMonth[index][innerindex]
                                                      .obligation ==
                                                  true
                                              ? Color(0xFFfa4b3c)
                                              : Colors.white,
                                      label: Container(
                                          width: 60,
                                          child: Center(
                                              child: FittedBox(
                                            child: Text(
                                              eventsByMonth[index][innerindex]
                                                          .obligation ==
                                                      true
                                                  ? 'Zorunlu'
                                                  : 'Zorunlu Değil',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color:
                                                    eventsByMonth[index]
                                                                    [innerindex]
                                                                .obligation ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          )))),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          eventsByMonth[index][innerindex]
                                              .title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          eventsByMonth[index][innerindex]
                                              .description,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Chip(
                                      backgroundColor: Colors.white,
                                      label: Container(
                                          width: 120,
                                          child: Center(
                                              child: Text(
                                            newdate.day.toString() +
                                                "." +
                                                newdate.month.toString() +
                                                "." +
                                                newdate.year.toString() +
                                                " " +
                                                newdate.hour.toString() +
                                                ":" +
                                                newdate.minute.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                      backgroundColor: Colors.white,
                                      label: Container(
                                          width: 100,
                                          child: Center(
                                              child: Text(
                                            "Süre: $dur DK",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
