import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sqflite_common/sqlite_api.dart';

class view extends StatefulWidget {
  Database database;

  view(this.database);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List name=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view_data();
  }

  view_data() async {
    String view = "select * from form";
    List<Map> m = [];
    m = await widget.database!.rawQuery(view);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: SlidableAutoCloseBehavior(child: Slidable(child: ListView.builder(itemBuilder: (context, index) {
        return ListTile(title: Text("${}"),);
      },),)),);
  }
}
