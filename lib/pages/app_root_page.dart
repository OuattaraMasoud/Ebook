import 'package:flutter/material.dart';
import 'package:tuto/pages/pages.dart';

class AppRootPage extends StatefulWidget {
  const AppRootPage({super.key});

  @override
  State<AppRootPage> createState() => _AppRootPageState();
}

class _AppRootPageState extends State<AppRootPage> {
  final List<Widget> _pages = [
    const MyHomePage(),
    const ExplorePage(),
    const SettingsPage()
  ];
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          selectedItemColor: Colors.blue,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ]),
    );
  }
}
