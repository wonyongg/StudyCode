import 'package:flutter/material.dart';

// 시작화면(Splash Screen)
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 코드 자동 정렬 -> mac os (Cmd + Option  + L)

    Future.delayed(Duration(seconds: 3), () {
      
      // 화면 이동 (splash -> main)
      // 정확히는 쌓아 올린 것, 뒤로가기누르면 SplashScreen으로 돌아감
      // Navigator는 화면 전환에 대한 기능을 가진 객체
      Navigator.pushNamed(context, '/main');
    },);

    return Scaffold(
        body: Center( // Center : 중앙 정렬 위젯
      child: Text('시작 화면입니다.'),
    ));
  }
}
