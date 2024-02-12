class Exam {
  String name;
  String time;
  String date;
  String id;

  Exam({required this.name, required this.time, required this.date, required this.id});

  factory Exam.fromMap(Map<String, dynamic> data) {
    return Exam(
      name: data['name'] ?? '',
      time: data['time'] ?? '',
      date: data['date'] ?? '',
      id: data['user_id'] ?? '',
    );
  }
}
