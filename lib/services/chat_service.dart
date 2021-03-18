import 'package:chat_app/models/mensaje_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final resp = await http.get(
        Uri(
            host: '192.168.1.5',
            port: 3000,
            path: '/api/mensajes/$usuarioID',
            scheme: 'http'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        });
    final mensajesResp = mensajesResponseFromJson(resp.body);
    return mensajesResp.mensajes;
  }
}
