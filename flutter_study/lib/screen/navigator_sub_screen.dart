import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 서브 화면
class NavigatorSubScreen extends StatelessWidget {
  String msg;

  NavigatorSubScreen({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 네비게이터 바 백스페이스 날림
        title: Text('서브 화면'),
        actions: [
          Icon(Icons.access_alarms_sharp),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                '뒤로가기',
                style: TextStyle(color: Colors.redAccent),
              ))
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text('서브화면입니다. $msg'),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('뒤로가기'))
        ],
      ),
    );
  }
}
