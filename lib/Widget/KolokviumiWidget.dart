import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/ExamModel.dart';

class Kolokviumi extends StatefulWidget {
  @override
  _KolokviumiState createState() => _KolokviumiState();
}


class _KolokviumiState  extends State<Kolokviumi> {

  List<Exam> exams = [];


  final List<String> titles = [
    'Title 1',
    'Title 2',
    'Title 3',
    'Title 4',
  ];

  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController timeController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String id = user.uid;
      FirebaseFirestore.instance
          .collection('Exam')
          .where('user_id', isEqualTo: id)
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
        } else {
          print('No documents found for the user.');
        }
      }).catchError((error) {
        print('Error retrieving data: $error');
      });
    }
  }


  void _add(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    TextEditingController dateController = TextEditingController();
    // Popup дијалог за креирање на предмет
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Форма за името, со контролер nameController
              TextFormField(decoration: const InputDecoration(labelText: 'Предмет'), controller: nameController),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  // Форма за датумот, со контролер dateController
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    selectedDate = pickedDate;
                    dateController.text =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Датум',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: dateController,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                // Форма за времето, со контролер timeController
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (pickedTime != null && pickedTime != selectedTime) {
                    selectedTime = pickedTime;
                    final formattedTime = '${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}';
                    timeController.text = formattedTime;
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Време',
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    controller: timeController,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Сме кликнале на копчето да се зачува, прво се зема логираникит корисник и пробуваме
                // на Exam колекцијата да го додадеме новиот испит.
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  String id = user.uid;
                  FirebaseFirestore.instance.collection('Exam').add({
                    'name': nameController.text,
                    'time': timeController.text,
                    'date': dateController.text,
                    'user_id': id,
                  });
                  print("Усошно е зачуван {nameController.text}");
                }
                fetchUserData();
                Navigator.of(context).pop();
              },
              child: Text('Зачувај'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('183213'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _add(context);
            },
          ),
        ],
      ),
      //Прикажи ги сите колоквиуми и испити како Grid
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ),
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    exams[index].name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'датум: ${exams[index].date} \nвреме: ${exams[index].time}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



