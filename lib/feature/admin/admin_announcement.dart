import 'package:flutter/material.dart';

class AdminAnnouncement extends StatefulWidget {
  const AdminAnnouncement({super.key});

  @override
  State<AdminAnnouncement> createState() => _AdmiAannouncementState();
}

class _AdmiAannouncementState extends State<AdminAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text("Duyuru"));
  }
}