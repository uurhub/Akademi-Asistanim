import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    final now = DateTime.now();
    final msg = now.hour >= 18 || now.hour < 6 ? "İyi Akşamlar" : "İyi Günler";
    return Scaffold(
      backgroundColor: Color(0xFFf5f6fa),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$msg Kullanıcı.",
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
                                    Icon(Icons.announcement, color: Colors.white, size: 90,),
                                    Text('Duyurular', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 16),),
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
                    SizedBox(height: 30,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            print("Etkinliklere Gider");
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
      )),
      bottomNavigationBar: footer(),
    );
  }

  BottomNavigationBar footer() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Ana Sayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.abc_sharp),
          label: 'ABC',
        ),
      ],
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
    );
  }
}
