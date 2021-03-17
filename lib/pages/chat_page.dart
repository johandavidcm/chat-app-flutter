import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  List<ChatMessage> _mensajes = [];
  bool _estaEscribiendo = false;

  @override
  void dispose() {
    //TODO: off del Socket
    for (ChatMessage message in _mensajes) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14.0,
            ),
            SizedBox(
              height: 3.0,
            ),
            Text(
              'Melisa Flores',
              style: TextStyle(color: Colors.black87, fontSize: 12.0),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              itemCount: _mensajes.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, i) => _mensajes[i],
              reverse: true,
            )),
            Divider(
              height: 1.0,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          children: [
            Flexible(
                child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (texto) {
                setState(() {
                  if (texto.trim().length > 0) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                });
              },
              decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
              focusNode: _focusNode,
            )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _estaEscribiendo
                          ? () => _handleSubmit(_textController.text)
                          : null)
                  : Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.send,
                            ),
                            onPressed: _estaEscribiendo
                                ? () => _handleSubmit(_textController.text)
                                : null),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String texto) {
    if (texto.trim().length == 0) {
      return;
    }
    final newMessage = new ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _mensajes.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
      _textController.clear();
      _focusNode.requestFocus();
    });
  }
}
