import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {

  // 사용자의 입력값이 아래 컨트롤러에 들어감
  TextEditingController idController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('텍스트 필드 화면'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          TextField(
            controller: idController,
            decoration: InputDecoration(labelText: '아이디를 입력해주세요.'),
          ),

          ElevatedButton(onPressed: () {
            // 클릭 시 동작 구현
            print(idController.text.toString());
          }, child: Text('아이디 입력값 가져오기'))
        ],
      ),
    );
  }
}
