import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'http_exception.dart';



class Authentication with ChangeNotifier{

  Future<void> login(String email, String password) async {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyD8v0Q6pe6mI0zXpB_34nnzw3PbVvkpRiQ';

    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }
      ));
      final responseData = json.decode(response.body);

      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }

      //print(responseData);
    } catch (error) {
      throw error;
    }

  }

  Future<void> signUp(String email, String password) async{

    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyD8v0Q6pe6mI0zXpB_34nnzw3PbVvkpRiQ';

    try{
      final response = await http.post(Uri.parse(url), body: jsonEncode(
          {
            'email' : email,
            'password' : password,
            'returnSecureToken' : true,
          }
      ));
      final responseData = json.decode(response.body);

      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }

      //print(responseData);
    }catch(error){
      throw error;
    }



  }

}

