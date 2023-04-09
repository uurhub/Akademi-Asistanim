import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:f_44_oua/feature/admin/admin_announcement.dart';
import 'package:f_44_oua/feature/admin/admin_events.dart';
import 'package:f_44_oua/feature/events/events_view.dart';
import 'package:flutter/material.dart';


class DataContainer extends InheritedWidget {
  final String? data;

  const DataContainer({super.key, required this.data, required Widget child})
      : super(child: child);

  static DataContainer? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataContainer>();
  }

  @override
  bool updateShouldNotify(DataContainer old) {
    return data != old.data;
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key, this.username});
  final username;
  @override
  State<AdminPage> createState() => _AdminPageState();
}



class _AdminPageState extends State<AdminPage> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final List<Widget> _pages = <Widget>[
    mainPage(),
    AdminAnnouncement(),
    AdminEvents(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f6fa),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: footer(),
    );
  }
  CurvedNavigationBar footer() {
    return CurvedNavigationBar(
        backgroundColor: Colors.white,
        buttonBackgroundColor: Color(0xff4285F4),
        color: Color(0xff4285F4),
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          _onItemTapped(index);
        },
        items: [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(
            Icons.add_comment_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.assignment_add,
            size: 30,
            color: Colors.white,
          ),
        ]);
  }
}
class mainPage extends StatefulWidget {
  const mainPage({super.key});
  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

 
  @override
  Widget build(BuildContext context) {
    final dataContainer = DataContainer.of(context);
    var temp = (dataContainer?.data)
        ?.substring(0, dataContainer?.data.toString().indexOf("@"));
    final us = temp![0].toString().toUpperCase() + temp.toString().substring(1);
    final now = DateTime.now();
    final msg = now.hour >= 18 || now.hour < 6 ? "İyi Akşamlar" : "İyi Günler";
    return SafeArea(
        child: Column(
      children: [
        Column(children: [
          Image.asset('assets/oua_logo.png', height: 128, width: 128),
        ]),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$msg $us.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          print("Duyurular Sayfasına Gider");
                        },
                        child: Container(
                          height: 177,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFDB4437),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.announcement,
                                color: Colors.white,
                                size: 90,
                              ),
                              Text(
                                'Duyurular',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("Görevlere Gider");
                        },
                        child: Container(
                          height: 177,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFF4285F4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.auto_graph_rounded,
                                color: Colors.white,
                                size: 90,
                              ),
                              Text(
                                'Görevler',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EventsView(),
                          ));
                        },
                        child: Container(
                          height: 177,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFF4B400),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 90,
                              ),
                              Text(
                                'Etkinlikler',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("Notlarıma Gider.");
                        },
                        child: Container(
                          height: 177,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFF0F9D58),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.note_rounded,
                                color: Colors.white,
                                size: 90,
                              ),
                              Text(
                                'Notlarım',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
