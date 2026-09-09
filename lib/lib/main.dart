import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ระบบลงเวลางาน',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AttendancePage(),
    );
  }
}

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String? checkInTime;
  String? checkOutTime;
  final List<Map<String, String>> history = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ลงเวลางานพนักงาน')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEEE, d MMMM yyyy', 'th_TH').format(DateTime.now()),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('เวลาเข้างาน', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text(
                        checkInTime ?? '--:--',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('เวลาออกงาน', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text(
                        checkOutTime ?? '--:--',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: checkInTime == null ? () => _checkIn() : null,
                      child: const Text('ลงเวลาเข้า', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: checkInTime != null && checkOutTime == null ? () => _checkOut() : null,
                      child: const Text('ลงเวลาออก', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    return Card(
                      child: ListTile(
                        title: Text(item['date'] ?? ''),
                        subtitle: Text('เข้า: ${item['in']} | ออก: ${item['out']}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkIn() {
    final time = DateFormat('HH:mm:ss').format(DateTime.now());
    setState(() => checkInTime = time);
  }

  void _checkOut() {
    final time = DateFormat('HH:mm:ss').format(DateTime.now());
    final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    setState(() {
      checkOutTime = time;
      history.insert(0, {'date': date, 'in': checkInTime!, 'out': time});
    });
  }
}
