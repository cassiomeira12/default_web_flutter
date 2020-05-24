import 'package:defaultwebflutter/models/singleton/singleton_user.dart';
import 'package:defaultwebflutter/presenter/user/user_presenter.dart';
import 'package:defaultwebflutter/screens/dashboard/dashboard_page.dart';
import 'package:defaultwebflutter/screens/notifications/notifications_page.dart';
import 'package:defaultwebflutter/screens/versions/versions_page.dart';
import 'package:defaultwebflutter/strings.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({this.logoutCallback});

  final VoidCallback logoutCallback;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  UserPresenter presenter;

  String userName;
  String titlePage;
  TabController controller;
  int active = 0;

  var listViews = [
    DashboardPage(),
    NotificationsPage(),
    VersionsPage(),
  ];

  @override
  void initState() {
    super.initState();
    userName = SingletonUser.instance.name;
    titlePage = listViews[0].toString();
    presenter = UserPresenter();
    controller = TabController(vsync: this, length: listViews.length, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = controller.index;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    presenter.dispose();
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
              body: body(),
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
        drawerItem(0, listViews[0].toString(), Icons.dashboard),
        drawerItem(1, listViews[1].toString(), Icons.notifications),
        drawerItem(2, listViews[2].toString(), Icons.phonelink_setup),
      ],
    );
  }

  Widget drawerItem(int index, String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: FlatButton(
        color: controller.index == index ? Colors.grey[700] : Colors.transparent,
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
          setState(() => titlePage = title);
          controller.animateTo(index);
          MediaQuery.of(context).size.width < 990 ? Navigator.pop(context) : null;
        },
      ),
    );
  }

  Widget body() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: controller,
      children: listViews,
    );
  }

}
