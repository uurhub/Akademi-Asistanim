import 'package:f_44_oua/feature/announcement/announcement_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final _announcementProvider = StateNotifierProvider<AnnouncementNotifier, AnnouncementState>((ref){
  return AnnouncementNotifier();
});

class AnnouncementView extends ConsumerStatefulWidget {
  const AnnouncementView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnnouncementViewState();
}

class _AnnouncementViewState extends ConsumerState<AnnouncementView> {

  void initState(){
    Future.microtask(() {
      ref.read(_announcementProvider.notifier).fetchAndLoad();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return _Announcement();
  }

}

class _Announcement extends ConsumerWidget {
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final announcementItems = ref.watch(_announcementProvider).duyurular ?? [];
    
      
    return Scaffold(
      appBar: AppBar(
        title: Text('Duyurular'),
        backgroundColor: Color(0xffDB4437),
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView.builder(
          itemCount: announcementItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: (index + 1) % 3 == 0 ? Color(0xffF4B400) : (index+1) % 2 == 0 ? Color(0xff0F9D58) : Color(0xff4285F4) ),
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Chip(
                            label: Text(
                              'Duyuru',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Icon(Icons.announcement_rounded),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ]),
                      Row(children: [Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(announcementItems[index].description.toString(),maxLines: 5,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),),
                        ),
                      )]),
                    ],
                  ),
                  height: 150),
            );
          },
        ),
      ),
    );
  }
}
