import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValueNotifierScreen extends StatefulWidget {
  const ValueNotifierScreen({super.key});

  @override
  State<ValueNotifierScreen> createState() => _ValueNotifierScreenState();
}

class _ValueNotifierScreenState extends State<ValueNotifierScreen> {
  // 사용자의 입력값이 아래 컨트롤러에 들어감
  TextEditingController idController = TextEditingController();
  String msg = '이 곳에 입력값이 업데이트 됩니다!';

  ValueNotifier<int> counter = ValueNotifier<int>(0);

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
              counter.value = 30;
            },
            child: Text('아이디 입력값 가져오기'),
          ),
          ValueListenableBuilder<int>(valueListenable: counter, builder: (context, value, child) {
            return Text('count : $value');
          },),
          Text(
            msg,
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
