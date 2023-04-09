import 'package:flutter/material.dart';

import 'flutterpage.dart';
import 'unitypage.dart';

class PassPage extends StatefulWidget {
  const PassPage({super.key});

  @override
  State<PassPage> createState() => _PassPageState();
}

class _PassPageState extends State<PassPage> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFf5f6fa),
      appBar: AppBar(title: Text("Görevlerim"), backgroundColor: Color(0xff4285F4),),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Center(child: Chip(backgroundColor: Color(0xff0F9D58),label: Text("Aylık Görevlerim",style:  TextStyle(fontSize: 24, color: Colors.white),)),),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FlutterPage(),
                            ));
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
                                  Icons.adb,
                                  color: Colors.white,
                                  size: 90,
                                ),
                                Text(
                                  '◄►𝙁𝙡𝙪𝙩𝙩𝙚𝙧',
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
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UnityPage(),
                            ));
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
                                  Icons.games_rounded,
                                  color: Colors.white,
                                  size: 90,
                                ),
                                Text(
                                  '◢◤𝙐𝙣𝙞𝙩𝙮',
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
  
    );
  }

 
}
