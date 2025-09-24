import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'face_registration_page.dart';
import 'face_recognition_page.dart';
import 'show_attendance_page.dart';

class MarkAttendancePage extends StatefulWidget {
  const MarkAttendancePage({super.key});

  @override
  State<MarkAttendancePage> createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideIn;

  final List<Map<String, dynamic>> attendanceItems = [
    {
      "title": "Face Registration",
      "subtitle": "Register your face",
      "icon": Icons.person_add,
      "bgColor": Colors.green.shade100,
      "target": FaceRegistrationPage(),
    },
    {
      "title": "Face Recognition",
      "subtitle": "Mark attendance via face",
      "icon": Icons.face,
      "bgColor": Colors.blue.shade100,
      "target": FaceRecognitionPage(),
    },
    {
      "title": "View Attendance",
      "subtitle": "Check your attendance records",
      "icon": Icons.list_alt,
      "bgColor": Colors.orange.shade100,
      "target": ShowAttendancePage(),
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
      appBar: AppBar(title: const Text("Mark Attendance")),
      body: Stack(
        children: [
          /// SVG background
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/background.svg",
              fit: BoxFit.cover,
              placeholderBuilder: (context) =>
                  Container(color: Colors.grey.shade200),
            ),
          ),

          /// Foreground content
          FadeTransition(
            opacity: _fadeIn,
            child: SlideTransition(
              position: _slideIn,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _responsiveRow(
                      attendanceItems.map((item) {
                        return _navigableCard(
                          context,
                          title: item["title"],
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

  Widget _navigableCard(
    BuildContext context, {
    required String title,
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
      child: _infoCard(title, subtitle, icon, bgColor),
    );
  }

  Widget _infoCard(
    String title,
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
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
          Container(
            width: 430,
            height: 932,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: 22,
                  top: 30,
                  child: Container(width: 28, height: 28, child: Stack()),
                ),
                Positioned(
                  left: 46,
                  top: 95,
                  child: Text(
                    'Student Data \nProfile ',
                    style: TextStyle(
                      color: const Color(0xFF223581),
                      fontSize: 29,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 293,
                  top: 852,
                  child: Container(
                    width: 123,
                    height: 47,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xE5485380),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 36,
                          top: 15,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 293,
                  top: 852,
                  child: Container(
                    width: 123,
                    height: 47,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xE5485380),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 36,
                          top: 15,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 250,
                  child: Container(
                    width: 430,
                    height: 423,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 27,
                          top: 6,
                          child: Container(
                            width: 391,
                            height: 92,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 11,
                                  top: 2,
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                      color: const Color(0xFF4E5864),
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 4,
                                  top: 31,
                                  child: Container(
                                    width: 371,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 2,
                                          color: const Color(0xFFE5E5FC),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 20,
                                          top: 14,
                                          child: Text(
                                            'Enter your Name',
                                            style: TextStyle(
                                              color: const Color(0xFFBDC1C6),
                                              fontSize: 17,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 64,
                                  top: 6,
                                  child: Text(
                                    '*',
                                    style: TextStyle(
                                      color: const Color(0xFFF63E3E),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 25,
                          top: 207,
                          child: Container(
                            width: 391,
                            height: 92,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 11,
                                  top: 2,
                                  child: Text(
                                    'Gender',
                                    style: TextStyle(
                                      color: const Color(0xFF4E5864),
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 4,
                                  top: 31,
                                  child: Container(
                                    width: 371,
                                    height: 55,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFF1F5F9),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 2,
                                          color: const Color(0xFFE8E8FD),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 14,
                                          top: 7,
                                          child: Container(
                                            width: 133,
                                            height: 41,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 39,
                                                  top: 10,
                                                  child: Text(
                                                    'Male',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 185,
                                          top: 8,
                                          child: Container(
                                            width: 133,
                                            height: 41,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFF1F5F9),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 39,
                                                  top: 10,
                                                  child: Text(
                                                    'Female',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 83,
                                  top: 4,
                                  child: Text(
                                    '*',
                                    style: TextStyle(
                                      color: const Color(0xFFF63E3E),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 27,
                          top: 110,
                          child: Container(
                            width: 391,
                            height: 92,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 11,
                                  top: 2,
                                  child: Text(
                                    'Father Name',
                                    style: TextStyle(
                                      color: const Color(0xFF4E5864),
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 4,
                                  top: 31,
                                  child: Container(
                                    width: 371,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 2,
                                          color: const Color(0xFFE5E5FC),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 20,
                                          top: 14,
                                          child: Text(
                                            'Enter your  Father Name',
                                            style: TextStyle(
                                              color: const Color(0xFFBDC1C6),
                                              fontSize: 17,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 125,
                                  top: 3,
                                  child: Text(
                                    '*',
                                    style: TextStyle(
                                      color: const Color(0xFFF63E3E),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 25,
                          top: 314,
                          child: Container(
                            width: 286,
                            height: 92,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 11,
                                  top: 2,
                                  child: Text(
                                    'Options',
                                    style: TextStyle(
                                      color: const Color(0xFF4E5864),
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 4,
                                  top: 31,
                                  child: Container(
                                    width: 263,
                                    height: 50,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 2,
                                          color: const Color(0xFFE5E5FC),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 20,
                                          top: 14,
                                          child: Text(
                                            'Enter your  Father Name',
                                            style: TextStyle(
                                              color: const Color(0xFFBDC1C6),
                                              fontSize: 17,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 87,
                                  top: 4,
                                  child: Text(
                                    '*',
                                    style: TextStyle(
                                      color: const Color(0xFFF63E3E),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 313,
                          top: 354,
                          child: Container(
                            width: 61,
                            height: 32,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://placehold.co/61x32",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 254,
                  top: 54,
                  child: Container(
                    width: 176,
                    height: 215,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://placehold.co/176x215"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
