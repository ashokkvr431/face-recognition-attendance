import 'package:flutter/material.dart';
import 'package:face/main.dart';

class ShowAttendancePage extends StatefulWidget {
  const ShowAttendancePage({super.key});

  // TODO: Fetch from backend
  final List<Map<String, dynamic>> attendanceRecords = const [
    {"date": "2025-09-18", "status": "Present"},
    {"date": "2025-09-17", "status": "Absent"},
    {"date": "2025-09-16", "status": "Present"},
  ];

  @override
  State<ShowAttendancePage> createState() => _ShowAttendancePageState();
}

class _ShowAttendancePageState extends State<ShowAttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance Records")),
      body: ListView.builder(
        itemCount: widget.attendanceRecords.length,
        itemBuilder: (context, index) {
          final record = widget.attendanceRecords[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(
                record["status"] == "Present"
                    ? Icons.check_circle
                    : Icons.cancel,
                color: record["status"] == "Present"
                    ? Colors.green
                    : Colors.red,
              ),
              title: Text("Date: ${record["date"]}"),
              subtitle: Text("Status: ${record["status"]}"),
            ),
          );
        },
      ),
    );
  }
}
