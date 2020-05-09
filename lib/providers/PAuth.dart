import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const api_key = " AIzaSyDcCH9WjhtcBt7be0UHPM1UUZWMVl-fo98";

class PAuth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String _userId;

  static const signupURL = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=";
  // static const signupURL = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";

  Future<void> signup(String email, String pwd) async {
    const url = PAuth.signupURL+api_key;

    final response = await http.post(url, body: json.encode({
      'email': email,
      'password': pwd, 
      'returnSecureToken': true,
    }));

    print(json.decode(response.body));
  }
}