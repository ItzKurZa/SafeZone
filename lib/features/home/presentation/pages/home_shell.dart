import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/app_bottom_nav_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../reports/presentation/pages/report_page.dart';
import '../../../emergency/presentation/pages/emergency_contacts_page.dart';
import 'home_dashboard_page.dart';
import '../../../chat/presentation/pages/chat_list_page.dart';
import '../../../emergency/presentation/widgets/floating_sos_button.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 2; // Default to Center blue button (Main Home Dashboard)

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ReportPage(onFinish: () {
        setState(() {
          _currentIndex = 2;
        });
      }), // Index 0
      const EmergencyContactsPage(), // Index 1: Emergency Contacts
      const HomeDashboardPage(), // Index 2: Main Dashboard
      const ChatListPage(), // Index 3
      const ProfilePage(), // Index 4
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: (_currentIndex == 0 || _currentIndex == 1)
          ? null
          : const FloatingSosButton(),
    );
  }
}
