import 'package:flutter/material.dart';
import 'package:fmdakgg/home_screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedItem = 0;
  final List<Widget> widgetOption = [const HomeScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widgetOption.elementAt(selectedItem),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedItem,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: '메세지',
              ),
            ]));
  }
}
