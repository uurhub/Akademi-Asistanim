import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DataContainerProfile extends InheritedWidget {
  final String? data;

  const DataContainerProfile(
      {super.key, required this.data, required Widget child})
      : super(child: child);

  static DataContainerProfile? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataContainerProfile>();
  }

  @override
  bool updateShouldNotify(DataContainerProfile old) {
    return data != old.data;
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFf5f6fa),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildTop(),
          buildContent(DataContainerProfile.of(context)?.data),
        ],
      ),
    );
  }

  Stack buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 40), child: buildCoverImage()),
        Positioned(top: 280 - 144 / 2, child: buildProfileImage())
      ],
    );
  }
}

Widget buildContent(var data) {
  final dataContainerHome = data;
  var temp = (dataContainerHome)
      ?.substring(0, dataContainerHome.toString().indexOf("@"));
  final us = temp![0].toString().toUpperCase() + temp.toString().substring(1);
  return Column(
    children: [
       Text(
        "$us",
        style: TextStyle(fontSize: 20),
      ),
      const SizedBox(
        height: 10,
      ),
      const Divider(
        thickness: 2,
        endIndent: 50,
        indent: 50,
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Genel Görevler Özeti",
        style: TextStyle(fontSize: 20),
      ),
      const SizedBox(
        height: 20,
      ),
      flutterPercent(),
      const SizedBox(
        height: 20,
      ),
      girisimcilikPercent(),
      const SizedBox(
        height: 20,
      ),
      englishPercent(),
      const SizedBox(
        height: 20,
      ),
      googlePercent(),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Card googlePercent() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: const Color(0xff0F9D58),
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Text(
            "Google Proje Yönetimi \nEğitimleri",
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 87,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 80,
              lineWidth: 10,
              percent: 1,
              progressColor: Colors.grey[800],
              backgroundColor: Colors.white60,
              circularStrokeCap: CircularStrokeCap.round,
              center: const Text(
                "%100",
                style: TextStyle(fontSize: 20, color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Card englishPercent() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: const Color(0xffF4B400),
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Text(
            "İngilizce Eğitimleri",
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 127,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 80,
              lineWidth: 10,
              percent: 0.4,
              progressColor: Colors.grey[800],
              backgroundColor: Colors.white60,
              circularStrokeCap: CircularStrokeCap.round,
              center: const Text(
                "%40",
                style: TextStyle(fontSize: 20, color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Card girisimcilikPercent() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: const Color(0xffDB4437),
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Text(
            "Teknoloji Girişimciliği \nEğitimleri",
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 90,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 80,
              lineWidth: 10,
              percent: 0.5,
              progressColor: Colors.grey[800],
              backgroundColor: Colors.white60,
              circularStrokeCap: CircularStrokeCap.round,
              center: const Text(
                "%50",
                style: TextStyle(fontSize: 20, color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Card flutterPercent() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: const Color(0xff4285F4),
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Text(
            "Flutter Eğitimleri",
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 142,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 80,
              lineWidth: 10,
              percent: 0.3,
              progressColor: Colors.grey[800],
              backgroundColor: Colors.white60,
              circularStrokeCap: CircularStrokeCap.round,
              center: const Text(
                "%30",
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildCoverImage() => Container(
      child: Image.asset(
        "assets/ouabackprofile.png",
        width: double.infinity,
        height: 280,
        fit: BoxFit.cover,
      ),
    );

Widget buildProfileImage() => Container(
      height: 100,
      width: 100,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Color(0xffF4F4F4),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: Image.asset('assets/oua_person.png'),
        )
      ),
    );
