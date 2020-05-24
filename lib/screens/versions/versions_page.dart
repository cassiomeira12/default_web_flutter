import 'package:defaultwebflutter/screens/versions/version_item_page.dart';
import 'package:defaultwebflutter/screens/versions/version_list_page.dart';
import 'package:defaultwebflutter/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/tabs.dart';

class VersionsPage extends StatefulWidget {

  @override
  _VersionsPageState createState() => _VersionsPageState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "Versões de App";
  }
}

class _VersionsPageState extends State<VersionsPage> with SingleTickerProviderStateMixin {
  final _formKey = new GlobalKey<FormState>();

  int currentTab = 0;

  var tabViews = [
    VersionListPage(),
    VersionItemPage(),
  ];

  TabsView tabs;

  @override
  void initState() {
    super.initState();
    tabs = TabsView(screens: tabViews,);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Scaffold(
        appBar: appBar(),
        body: tabs,
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          currentTab == 0 ?
          Container(
            width: 200,
            child: PrimaryButton(
              text: "Novo",
              onPressed: () {
                setState(() {
                  currentTab = 1;
                });
                tabs.setPage(currentTab);
              },
            ),
          ) : Container(),

          currentTab == 1 ?
          Container(
            width: 200,
            child: PrimaryButton(
              text: "Voltar",
              onPressed: () {
                setState(() {
                  currentTab = 0;
                });
                tabs.setPage(currentTab);
              },
            ),
          ) : Container(),

        ],
      ),
    );
  }

  Widget page1() {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 100,),
            body2(Colors.green),
            body2(Colors.red),
            body2(Colors.blue),
            body2(Colors.black),
            body2(Colors.green),
          ],
        ),
      ],
    );
  }

  Widget actions() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 200,
                child: PrimaryButton(
                  text: "Novo",
                  onPressed: () {
                    tabs.setPage(0);
                  },
                ),
              ),

              Container(
                width: 200,
                child: PrimaryButton(
                  text: "Remover",
                  onPressed: () {
                    tabs.setPage(1);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget body2(Color cor) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      color: cor,
    );
  }

}
