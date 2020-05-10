import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const api_key = " AIzaSyDcCH9WjhtcBt7be0UHPM1UUZWMVl-fo98";

class PAuth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _expiryTimer;

  bool get isAuth{
    return this.token != null;
  }

  String get token{
    if(this._expiryDate != null &&
      this._token != null &&
      _expiryDate.isAfter(DateTime.now())
    ){
      return this._token;
    }
    return null;
  }

  String get userId{
    return _userId;
  }

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

    this._token = responseBody['idToken'];
    this._userId = responseBody['localId'];
    this._expiryDate = DateTime.now().add(
      Duration(seconds: int.parse(responseBody['expiresIn']))
    );

    notifyListeners();
  }

  Future<void> signup(String email, String pwd) async {
    await this._auth(email, pwd, 'signUp');
  }

  Future<void> login(String email, String pwd) async {
    await this._auth(email, pwd, 'signInWithPassword');

    this.autologout();

    final userData = json.encode({
      'token': this._token,
      'userId': this._userId,
      'expiryDate': this._expiryDate.toString(),
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', userData);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if(! prefs.containsKey('userData')) return false;

    final userData = json.decode(prefs.getString('userData')) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(userData['expiryDate']);

    if(expiryDate.isBefore(DateTime.now())) return false;

    this._token = userData['token'];
    this._userId = userData['userId'];
    this._expiryDate = expiryDate;

    notifyListeners();
    return true;
  }

  void logout() async {
    this._userId = null;
    this._token = null;
    this._expiryDate = null;

    if(this._expiryTimer != null){
      this._expiryTimer.cancel();
      this._expiryTimer = null;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    notifyListeners();
  }

  void autologout(){
    if(this._expiryTimer != null){
      this._expiryTimer.cancel();
    }

    final timeToExpiry = this._expiryDate.difference(DateTime.now()).inSeconds;

    this._expiryTimer = Timer(
      Duration(seconds: timeToExpiry),
      this.logout
    );
  }
}