import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인화면'),
      ),
      body: Column(
        children: [
          TextButton(onPressed: () {
            // 서브 화면으로 이동(생성하면서 이동)
            Navigator.pushNamed(context, '/sub');
            // 서브 화면으로 이동(현재 화면을 스택에서 제거하고 다음 화면으로 교체하여 이동)
            // Navigator.pushReplacementNamed(context, '/sub');
          }, child: Text('클릭하여 서브 화면으로 이동')),
        ],
      ),
    );
  }
}
