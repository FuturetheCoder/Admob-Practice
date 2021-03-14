import 'package:admobpractice/ad_manager.dart';
import 'package:admobpractice/app_theme.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: FutureBuilder<void>(
        future: _initAdMob(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          List<Widget> children = <Widget>[
            Text(
              "Awesome Drawing Quiz!",
              style: TextStyle(
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 72),
            ),
          ];

          if (snapshot.hasData) {
            children.add(RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text(
                "Let's get started!".toUpperCase(),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 48,
              ),
              onPressed: () => Navigator.of(context).pushNamed('/game'),
            ));
          } else if (snapshot.hasError) {
            children.addAll(<Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
            ]);
          } else {
            children.add(SizedBox(
              child: CircularProgressIndicator(),
              width: 48,
              height: 48,
            ));
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }
}
