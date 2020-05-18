import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          MediaQuery.of(context).size.width < 800 ? Container() : drawer(),
          Expanded(
            child: Scaffold(
              appBar: appBar(),
              backgroundColor: Colors.grey,
              drawer: MediaQuery.of(context).size.width > 800 ? null : drawer(),
              body: body(),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text("Teste"),
    );
  }

  Widget drawer() {
    return Drawer(
      child: drawerItens(),
    );
  }

  Widget drawerItens() {
    return ListView(
      children: [
        FlatButton(
          //color: tabController.index == 0 ? Colors.grey[100] : Colors.white,
          //color: Colors.grey[100],
//          onPressed: () {
//            tabController.animateTo(0);
//            drawerStatus ? Navigator.pop(context) : print("");
//          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(Icons.dashboard),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'HelveticaNeue',
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget body() {
    return Container(
      color: Colors.red,
    );
  }

}
