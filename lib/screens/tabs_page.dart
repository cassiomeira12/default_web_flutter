import 'package:defaultwebflutter/models/singleton/singleton_user.dart';
import 'package:defaultwebflutter/presenter/user/user_presenter.dart';
import 'package:defaultwebflutter/screens/dashboard/dashboard_page.dart';
import 'package:defaultwebflutter/screens/notifications/notifications_page.dart';
import 'package:defaultwebflutter/screens/versions/versions_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/tabs.dart';

class TabsPage extends StatefulWidget {
  TabsPage({this.logoutCallback});

  final VoidCallback logoutCallback;

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final PageStorageBucket bucket = PageStorageBucket();

  UserPresenter presenter;

  int currentTab = 0;
  List<Widget> screens = [
    DashboardPage(),
    NotificationsPage(),
    VersionsPage(),
  ];

  String userName;
  String titlePage;

  TabsView tabs;

  @override
  void initState() {
    super.initState();
    presenter = UserPresenter();
    userName = SingletonUser.instance.name;
    titlePage = screens[currentTab].toString();
    tabs = TabsView(currentTab: currentTab, screens: screens,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          MediaQuery.of(context).size.width < 990 ? Container() : drawer(),
          Expanded(
            child: Scaffold(
              appBar: appBar(),
              drawer: MediaQuery.of(context).size.width > 990 ? null : drawer(),
              body: tabs,
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text(
        titlePage,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      iconTheme: Theme.of(context).iconTheme,
      backgroundColor: Colors.white,
      actions: <Widget>[
        Container(
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.exit_to_app,),
            onPressed: () {
              presenter.signOut();
              widget.logoutCallback();
            },
          ),
        ),
        SizedBox(width: 32),
      ],
    );
  }

  Widget drawer() {
    return Container(
      child: Drawer(
        elevation: 5.0,
        child: drawerItens(),
      ),
    );
  }

  Widget drawerItens() {
    return ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 48,
                child: Image.asset("assets/logo_app.png"),
              ),
              Text(
                "Olá, ${userName.toString().split(" ").first}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        drawerItem(0, screens[0].toString(), Icons.dashboard),
        drawerItem(1, screens[1].toString(), Icons.notifications),
        drawerItem(2, screens[2].toString(), Icons.phonelink_setup),
      ],
    );
  }

  Widget drawerItem(int index, String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: FlatButton(
        color: currentTab == index ? Colors.grey[700] : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.only(top: 16, bottom: 16, right: 16),
            child: Row(children: [
              Icon(icon),
              SizedBox(width: 8,),
              Text(
                title.toUpperCase(),
              ),
            ]),
          ),
        ),
        onPressed: () {
          setState(() {
            titlePage = title;
            currentTab = index;
            tabs.setPage(index);
          });
          MediaQuery.of(context).size.width < 990 ? Navigator.pop(context) : null;
        },
      ),
    );
  }

}
