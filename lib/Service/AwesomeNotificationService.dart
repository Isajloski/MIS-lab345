import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import 'package:lab3/Model/LocationModel.dart';

import '../Model/ExamModel.dart';

class AwesomeNotificationService{

  void init(){
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests.'
          )
        ],
        debug: true
    );
  }

  void triggerNotification(List <Exam> exams){
    print("bev povikan");
    for (Exam exam in exams){
      DateTime date = DateFormat("dd-MM-yyyy HH:mm").parse("${exam.date} ${exam.time}");
      if(date.isBefore(DateTime.now())) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: Random().nextInt(1000),
              channelKey: 'basic_channel',
              title: 'Потсетник за испит ${exam.name}',
              body: 'Го полагате предметот во ${exam.time} часот'
          ),
          schedule: NotificationCalendar(
              minute: date.subtract(const Duration(minutes: 5)).minute,
              second: date.second,
              hour: date.hour,
              day: date.day,
              month: date.month,
              year: date.year
          ),
        );
        print("Name: ${exam.name}\nTime: ${exam.time}\nDate: ${exam.date} + ${date} \n Now: ${DateTime.now()}");
        print("УСПЕШНО");
      }
    }

  }

  void triggerNotificationLocation(List<LocationModel> locations) {

    print("bev povikan");
    for (LocationModel location in locations){
      DateTime date = DateFormat("dd-MM-yyyy HH:mm").parse("${location.date} ${location.time}");
      if(date.isAfter(DateTime.now())) {
        print(location.name);
        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: Random().nextInt(1000),
              channelKey: 'basic_channel',
              title: 'Локациски потсетник ${location.name}',
              body: 'Време ${location.time} часот'
          ),
          schedule: NotificationCalendar(
              minute: date.subtract(const Duration(minutes: 5)).minute,
              second: date.second,
              hour: date.hour,
              day: date.day,
              month: date.month,
              year: date.year
          ),

        );
        print("Name: ${location.name}\nTime: ${location.time}\nDate: ${location.date} + ${date} \n Now: ${DateTime.now()}");
        print("УСПЕШНО");
      }
    }

  }



}