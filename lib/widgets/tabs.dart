import 'package:flutter/material.dart';

class TabsView extends StatefulWidget {
  int currentTab;
  List<Widget> screens;

  TabsView({
    this.currentTab = 0,
    @required this.screens
  });

  _TabsViewState page;

  @override
  _TabsViewState createState() => page = _TabsViewState();

  setPage(int index) {
    page.setPage(index);
  }

}

class _TabsViewState extends State<TabsView> {
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen;

  @override
  void initState() {
    super.initState();
    currentScreen = widget.screens[widget.currentTab];
  }

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: bucket,
      child: currentScreen,
    );
  }

  setPage(int index) {
    setState(() {
      currentScreen = widget.screens[index];
    });
  }

}
