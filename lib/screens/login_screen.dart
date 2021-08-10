import 'package:flutter/material.dart';

import 'signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:login_app/models/authentication.dart';
import 'home_screen.dart';



class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String,String> _authData = {
    'email' : '',
    'password' : '',
  };

  void _showErrorDialog(String msg){
    showDialog(
        context: context,
        builder: (ctx)=> AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: [
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  Future<void> _submit() async{
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context,listen: false).login(
          _authData['email'],
          _authData['password']
      );

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }catch(error){
      var errorMessage = 'Authentication Failed,Try again later';
      _showErrorDialog(errorMessage);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          FlatButton(
            child: Row(
              children: [
                Text('Signup'),
                Icon(Icons.person_add)
              ],
            ),
            textColor: Colors.white70,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);

            },
          )
        ],
      ),

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightGreenAccent,
                  Colors.blue
                ]
              )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 260,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value.isEmpty || !value.contains('@')){
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _authData['email'] = value;
                          },
                        ),

                        //Password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value){
                            if(value.isEmpty || value.length<=5){
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _authData['password'] = value;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                            child: Text(
                              'Submit'
                            ),
                          onPressed: (){
                              _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),

                          ),
                          color: Colors.blue,
                          textColor: Colors.white70,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
