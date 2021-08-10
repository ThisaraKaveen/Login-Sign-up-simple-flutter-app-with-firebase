import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          FlatButton(
            child: Row(
              children: [
                Icon(Icons.arrow_back),
                Text('Back'),
              ],
            ),
            textColor: Colors.white70,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);

            },
          )
        ],
      ),
      body: Center(
        child: Text('This is home screen',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          ),
        ),
      ),
    );
  }
}
