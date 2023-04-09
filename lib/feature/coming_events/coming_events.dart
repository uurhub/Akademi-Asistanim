import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../events/events_provider.dart';

final _eventsProvider =
    StateNotifierProvider<EventsNotifier, EventsState>((ref) {
  return EventsNotifier();
});

class ComingEvents extends ConsumerStatefulWidget {
  const ComingEvents({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComingEventsState();
}

class _ComingEventsState extends ConsumerState<ComingEvents> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(_eventsProvider.notifier).fetchAndLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _yaklasanEvent();
  }
}

class _yaklasanEvent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsItems = ref.watch(_eventsProvider).etkinlikler ?? [];

    final eventsByMonth = List.generate(12, (index) => []);

    late final item;
    late final newdate;
    for (var event in eventsItems) {
      DateTime date = DateTime.parse(event.date.toString());
      final eventMonth = date.month;
      eventsByMonth[eventMonth - 1].add(event);
    }
    for (var monthEvents in eventsByMonth) {
      monthEvents.sort((a, b) => a.date.compareTo(b.date));
    }
    DateTime now = DateTime.now();
    if (eventsByMonth[now.month - 1].isEmpty)
      item = null;
    else {
      item =
          eventsByMonth[now.month - 1][eventsByMonth[now.month - 1].length - 1];
           newdate = DateTime.parse(item.date.toString());
    }

    return item != null ? Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chip(label: Text("Gelecek Etkinlik",style: TextStyle(fontSize: 16),)),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(8)),
              height: 160,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(
                            backgroundColor: item.obligation == true
                                ? Color(0xFFfa4b3c)
                                : Colors.white,
                            label: Container(
                                width: 60,
                                child: Center(
                                    child: FittedBox(
                                  child: Text(
                                    item.obligation == true
                                        ? 'Zorunlu'
                                        : 'Zorunlu Değil',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: item.obligation == true
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
                                item.title,
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
                                item.description,
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
                                      fontWeight: FontWeight.w600, fontSize: 16),
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
                                  "Süre: " + item.duration + " DK",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 16),
                                )))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ) : Center(child: CircularProgressIndicator());
  }
}
