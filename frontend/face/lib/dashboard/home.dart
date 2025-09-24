import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'apply_leave.dart';
import 'mark_attendance_page.dart';
import 'show_leave.dart';
import 'show_attendance_page.dart'; // ✅ keep only this
// import 'show_attendance_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideIn;

  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "Mark Attendance",
      "value": "QR / Manual",
      "subtitle": "Mark your daily attendance",
      "icon": Icons.location_on,
      "bgColor": Color.fromARGB(221, 233, 243, 233),
      "target": MarkAttendancePage(),
    },
    {
      "title": "Show Attendance",
      "value": "Overview",
      "subtitle": "Check attendance summary",
      "icon": Icons.bar_chart,
      "bgColor": Color.fromARGB(221, 228, 238, 243),
      "target": ShowAttendancePage(), // ✅ your class name
    },
    {
      "title": "Apply Leave",
      "value": "Request",
      "subtitle": "Submit leave application",
      "icon": Icons.check_box,
      "bgColor": Color.fromARGB(232, 228, 233, 238),
      "target": ApplyLeavePage(),
    },
    {
      "title": "Show Leave",
      "value": "History",
      "subtitle": "View all your leave records",
      "icon": Icons.event_note,
      "bgColor": Color.fromARGB(221, 238, 234, 228),
      "target": ShowLeavePage(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _responsiveRow(List<Widget> children, {int columns = 3}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth < 900;
        final colCount = isMobile ? 1 : (isTablet ? 2 : columns);

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: children.map((child) {
            return SizedBox(
              width:
                  (constraints.maxWidth / colCount) -
                  (12 * (colCount - 1)) / colCount,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Face App - Home")),
      body: Stack(
        children: [
          /// ✅ SVG background
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/background.svg",
              fit: BoxFit.cover,
              placeholderBuilder: (context) =>
                  Container(color: Colors.grey.shade200),
            ),
          ),

          /// ✅ Foreground content
          FadeTransition(
            opacity: _fadeIn,
            child: SlideTransition(
              position: _slideIn,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _responsiveRow(
                      menuItems.map((item) {
                        return _navigableInfoCard(
                          context,
                          title: item["title"],
                          value: item["value"],
                          subtitle: item["subtitle"],
                          icon: item["icon"],
                          bgColor: item["bgColor"],
                          target: item["target"],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigableInfoCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color bgColor,
    required Widget target,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => target));
      },
      child: _infoCard(title, value, subtitle, icon, bgColor),
    );
  }

  Widget _infoCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color bgColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: Colors.black54),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
