import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 서브 화면
class NavigatorSubScreen extends StatefulWidget {
  const NavigatorSubScreen({super.key});

  @override
  State<NavigatorSubScreen> createState() => _NavigatorSubScreenState();
}

class _NavigatorSubScreenState extends State<NavigatorSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('서브 화면'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('서브화면입니다.'),
          ),
        ],
      ),
    );
  }
}
