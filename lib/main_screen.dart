import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/home_screen/home_screen.dart';
import 'package:fmdakgg/messange_screen/message_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int selectedItem = 0;
  final List<Widget> widgetOption = [const HomeScreen(), const MessageScreen()];

  void _onItemTapped(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widgetOption.elementAt(selectedItem),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              selectedItem = value;
              setState(() {});
            },
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
