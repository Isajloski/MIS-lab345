import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab3/Service/NotificationService.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Model/ExamModel.dart';
import '../Service/AwesomeNotificationService.dart';
import '../navigation_bar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<CalendarWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int _currentIndex = 1;
  DateTime selected = DateTime.now();
  DateTime today = DateTime.now();

  List<Exam> exams = [];

  void _onDaySelected(DateTime day, DateTime focused) {
    setState(() {
      selected = day;
    });
    fetchUserData();

  }


  void fetchUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String id = user.uid;
      FirebaseFirestore.instance
          .collection('Exam')
          .where('user_id', isEqualTo: id)
          .where('date', isEqualTo: DateFormat('dd-MM-yyyy').format(selected))
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          exams.clear();
          querySnapshot.docs.forEach((doc) {
            if (doc.data() is Map<String, dynamic>) {
              exams.add(Exam.fromMap(doc.data() as Map<String, dynamic>));
            }
          });
          setState(() {
            exams = exams;
          });
          AwesomeNotificationService().triggerNotification(exams);
        } else {
          print('No documents found for the user.');
          setState(() {
            exams = [];
          });
        }
      }).catchError((error) {
        print('Error retrieving data: $error');
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Calendar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              selectedDayPredicate: (day) => isSameDay(day, selected),
              focusedDay: DateTime.now(),
              lastDay: DateTime.utc(2025),
              onDaySelected: _onDaySelected,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(exams[index].name),
                  subtitle: Text('${exams[index].time} - ${exams[index].date}'),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

}
