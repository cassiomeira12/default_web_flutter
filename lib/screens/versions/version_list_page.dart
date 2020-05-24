import 'package:defaultwebflutter/models/version.dart';
import 'package:defaultwebflutter/presenter/version_presenter.dart';
import 'package:defaultwebflutter/services/firebase/firebase_version_service.dart';
import 'package:defaultwebflutter/strings.dart';
import 'package:defaultwebflutter/widgets/inputField.dart';
import 'package:defaultwebflutter/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class VersionListPage extends StatefulWidget {

  @override
  _VersionListPageState createState() => _VersionListPageState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "Versão de App";
  }
}

class _VersionListPageState extends State<VersionListPage> {
  final _formKey = new GlobalKey<FormState>();

  VersionPresenter presenter;

  List<int> listVersions = [1,2,3];

  @override
  void initState() {
    super.initState();
    presenter = VersionPresenter();
    //list();
  }

  @override
  void dispose() {
    super.dispose();
    presenter.dispose();
  }

  void list() async {
    var list = await presenter.list();
    if (list != null) {
      setState(() {
        //listVersions = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          //child: body(),
          child: listVersions != null ?
          ListView.builder(
            itemCount: listVersions.length,
            itemBuilder: (BuildContext context, int index) {
              return card();
            }
          ) : Container(),
        ),
      ),
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          card(),
          card(),
          card(),
          card(),
        ],
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
