import 'package:flutter/material.dart';

import '../calculator/calculator_screen.dart';
import '../../widgets/common/bottom_nav_bar.dart';
import '../../widgets/common/app_top_bar.dart';
import '../tools/screens/tools_screen.dart';

import '../home/new_home_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int currentIndex = 0;

  final pages = <Widget>[
    const NewHomeScreen(),
    const CalculatorScreen(),
    const ToolsScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true, // REQUIRED FOR FLOATING NAV

      body: Column(
        children: [

          /// 🔹 TOP BAR
          AppTopBar(
            currentIndex: currentIndex,
            title: currentIndex == 1 ? "Calculator" : null,
            onBack: () {
              setState(() => currentIndex = 0);
            },
          ),

          /// 🔹 PAGE CONTENT
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: pages,
            ),
          )
        ],
      ),

      /// 🔹 FLOATING NAV
      bottomNavigationBar: SafeArea(
        top: false,
        child: BottomNavBar(
          currentIndex: currentIndex,
          onChanged: (i) {
            setState(() => currentIndex = i);
          },
        ),
      ),

    );
  }
}
