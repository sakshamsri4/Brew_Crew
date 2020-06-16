import 'package:flutter/material.dart';
import 'package:flutterfirebase/Models/user.dart';
import 'package:flutterfirebase/Services/database.dart';
import 'package:flutterfirebase/shared/constants.dart';
import 'package:flutterfirebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  @override

  //form values
  String _currentName, _currentSugars;
  int _currentStrength;

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew Settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),

                  //slider
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),

                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate())
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentSugars ?? userData.sugars,
                            _currentStrength ?? userData.strength);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
