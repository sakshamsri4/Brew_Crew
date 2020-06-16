import 'package:flutter/material.dart';
import 'package:flutterfirebase/Models/brew.dart';
import 'package:flutterfirebase/Screens/Home/brewlist.dart';
import 'package:flutterfirebase/Screens/Home/setting_form.dart';
import 'package:flutterfirebase/Services/auth.dart';
import 'package:flutterfirebase/Services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew Crew'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Setting'),
              onPressed: () => _showSettingPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/coffee_bg1.png'))),
          child: BrewList(),
        ),
      ),
    );
  }
}
