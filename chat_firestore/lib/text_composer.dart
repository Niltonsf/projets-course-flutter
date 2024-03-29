import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage);

  final Function({String text, File imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

  bool _isComposing = false;

  //Enviar mensagem, apagar campo de mensagem apos enviar e mudar estado do Botao para false
  void _resetField (texto){
    widget.sendMessage(text: texto);
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async{
              final File imgFile = await ImagePicker.pickImage(source: ImageSource.camera);
              if (imgFile == null) return;
              widget.sendMessage(imgFile: imgFile);
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration.collapsed(
                hintText: "Enviar uma mensagem",
              ),
              onChanged: (text){
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text){
                _resetField(text);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing ? (){
              _resetField(_controller.text);
              //_resetField();
            } : null,
          )
        ],
      ),
    );
  }
}