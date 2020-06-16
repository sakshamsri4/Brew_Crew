import 'package:flutter/material.dart';
import 'package:flutterfirebase/Models/user.dart';
import 'package:flutterfirebase/Screens/Authenticate/Authenticate.dart';
import 'package:flutterfirebase/Screens/Home/Home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO:Either return home or authenticate.
    final user = Provider.of<User>(context);

    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}
