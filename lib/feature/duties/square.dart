import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  final String child;
  final Color color; 
  final late;
  MySquare({required this.child, required this.color, this.late});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
      
          height: late ? 300 : 450,
          child: Center(
              child: Text(
            child,
            style: TextStyle(fontSize: 20),
          ),)
        ),
      ),
    );
  }
}
