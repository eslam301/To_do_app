import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/HomeView.dart';
import 'package:todo_app/Screens/settingsView.dart';
import 'package:todo_app/widgets/bottom_sheet_widget.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "homeLayout";

  HomeLayout({super.key});
  int selectedIndex = 0;
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;
  List<Widget> pages = [const HomeView(), const SettingsView()];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          padding: const EdgeInsets.all(4),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white,),
          child: FloatingActionButton(
            onPressed: () {
              showAddTaskBottomSheet();
            },
            child: const Icon(Icons.add,size: 30,),
          )),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 13,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage("assets/images/Icons/Icon awesome-list.png")
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage(
                    "assets/images/Icons/Icon feather-settings.png")
                ),
                label: "settings")
          ],
        ),
      ),
    );
  }

  void showAddTaskBottomSheet () {
    showModalBottomSheet(context: context, builder: (context)=>BottomSheetWidget());

  }
}
