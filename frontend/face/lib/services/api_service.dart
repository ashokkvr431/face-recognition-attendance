import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.70.9.32:8000";

  // Check backend running
  static Future<String> checkBackend() async {
    final response = await http.get(Uri.parse("$baseUrl/"));
    return response.body;
  }

  // Register user
  static Future<String> register(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );
    return response.body;
  }

  // Login user
  static Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );
    return response.body;
  }

  // Mark attendance
  static Future<String> markAttendance(String username, String status) async {
    final response = await http.post(
      Uri.parse("$baseUrl/attendance/mark"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "status": status}),
    );
    return response.body;
  }

  // Get attendance list
  static Future<String> getAttendanceList() async {
    final response = await http.get(Uri.parse("$baseUrl/attendance/list"));
    return response.body;
  }
}
