import 'dart:convert';

import 'package:chat_app/models/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};
    final resp = await http.post(
        Uri(
            host: '192.168.1.5',
            port: 3000,
            path: '/api/login',
            scheme: 'http'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    }
    return false;
  }

  Future register(String email, String password, String name) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password, 'nombre': name};
    final resp = await http.post(
        Uri(
            host: '192.168.1.5',
            port: 3000,
            path: '/api/login/new',
            scheme: 'http'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});
    this.autenticando = false;
    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    }
    final respBody = jsonDecode(resp.body);
    return respBody['msg'];
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final resp = await http.get(
        Uri(
            host: '192.168.1.5',
            port: 3000,
            path: '/api/login/renew',
            scheme: 'http'),
        headers: {'Content-Type': 'application/json', 'x-token': token});
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    }
    this.logout();
    return false;
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.deleteAll();
  }
}
