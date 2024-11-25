import 'package:flutter/material.dart';
import 'package:myqrcodeapp/feature/home/presentation/page/home_page.dart';

class TabBarScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function toggleTheme;

  const TabBarScreen(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: const TabBar(tabs: [
          Icon(Icons.home),
          Icon(Icons.date_range),
        ]),
        body: TabBarView(
          children: [HomePage()],
        ),
      ),
    );
  }
}
