import 'package:SwipeList/View/mapview.dart';
import 'package:SwipeList/services/locationservice.dart';
import "package:flutter/material.dart";
import 'package:SwipeList/services/api.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_share/flutter_share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> countries = [];

  @override
  void initState() {
    LocationService().getCurrentLocation();
    API.getCountries().then((value) {
      this.countries = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SwipeList View")),
      body: countries == null
          ? Center(child: Text("Loading.."))
          : ListView.builder(
              itemCount: countries.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Maps();
                      }));
                    },
                    child: Slidable(
                      key: ValueKey(index),
                      actionPane: SlidableDrawerActionPane(),
                      closeOnScroll: true,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                            caption: "Share",
                            icon: Icons.share,
                            color: Colors.blue,
                            onTap: () async {
                              await FlutterShare.share(
                                  title: "Share",
                                  chooserTitle: "Select",
                                  linkUrl: countries[index]);
                            }),
                        IconSlideAction(
                          caption: "Delete",
                          icon: Icons.delete,
                          color: Colors.red,
                          onTap: () {
                            countries.removeAt(index);
                            setState(() {});
                          },
                        )
                      ],
                      child: ListTile(title: Text(countries[index])),
                    ));
              }),
    );
  }
}
