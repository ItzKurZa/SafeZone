import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';
import '../../../../core/theme/app_colors.dart';
import 'sos_list_page.dart';
import 'rescuer_map_page.dart';
import 'rescuer_chat_page.dart';
import 'rescuer_report_page.dart';

class RescuerHomeShell extends StatefulWidget {
  final int initialIndex;
  const RescuerHomeShell({super.key, this.initialIndex = 0});

  @override
  State<RescuerHomeShell> createState() => _RescuerHomeShellState();
}

class _RescuerHomeShellState extends State<RescuerHomeShell> {
  late int _currentIndex;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pages = [
      const SosListPage(),       // Index 0: Missions
      const RescuerMapPage(),    // Index 1: Map
      const SosListPage(),       // Index 2: Center button (Radar/Radar - for now SOS List)
      const RescuerChatPage(),   // Index 3: Team
      const RescuerReportPage(), // Index 4: Reports
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: RescuerBottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
