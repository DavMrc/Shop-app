import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const api_key = " AIzaSyDcCH9WjhtcBt7be0UHPM1UUZWMVl-fo98";

class PAuth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _auth(String email, String pwd, String service) async {
    final url = "https://identitytoolkit.googleapis.com/v1/accounts:$service?key=$api_key";

    final response = await http.post(url, body:json.encode({
      'email': email,
      'password': pwd, 
      'returnSecureToken': true,
    }));
    final responseBody = json.decode(response.body);

    if(responseBody['error'] != null){    // an error occurred
      throw HttpException(responseBody['error']['message']);
    }

    print(responseBody);
  }

  Future<void> signup(String email, String pwd) async {
    return this._auth(email, pwd, 'signUp');
  }

  Future<void> login(String email, String pwd) async {
    return this._auth(email, pwd, 'signInWithPassword');
  }
}