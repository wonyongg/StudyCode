import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetStateScreen extends StatefulWidget {
  const SetStateScreen({super.key});

  @override
  State<SetStateScreen> createState() => _SetStateScreenState();
}

class _SetStateScreenState extends State<SetStateScreen> {
  // 사용자의 입력값이 아래 컨트롤러에 들어감
  TextEditingController idController = TextEditingController();
  String msg = '이 곳에 입력값이 업데이트 됩니다!';

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
          ElevatedButton(
            onPressed: () {
              // 클릭 시 동작 구현
              setState(() {
                // 위젯 업데이트(화면 전체가 아닌 특정 사용처에 대해서만 업데이트하기 때문에 퍼포먼스에 좋다.)
                msg = idController.text
                    .toString(); // msg위젯의 사용처 값이 업데이트 됨, 아래의 msg
              });
              print(msg); // 서버 로그 남기기
            },
            child: Text('아이디 입력값 가져오기'),
          ),
          Text(
            msg,
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
