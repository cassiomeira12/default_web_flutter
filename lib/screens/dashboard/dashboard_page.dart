import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {

  @override
  _DashboardPageState createState() => _DashboardPageState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "Dashboard";
  }

}

class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
            card(),
          ],
        ),
      ),
    );
  }

  Widget card() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
      width: MediaQuery.of(context).size.width < 500 ? MediaQuery.of(context).size.width / 1.3 : 250,
      height: 150,
      child: Card(
        elevation: 5.0,
        color: Colors.white,
      ),
    );
  }
}
