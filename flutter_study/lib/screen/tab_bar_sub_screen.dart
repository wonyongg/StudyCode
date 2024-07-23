import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarSubScreen extends StatelessWidget {
  String msg;

  TabBarSubScreen({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('메인화면'),
          actions: [
            Icon(Icons.accessibility_rounded),
          ],
          bottom: TabBar(tabs: [ // 탭을 만들 수 있다.
            Tab(text: 'Tab 1',),
            Tab(text: 'Tab 2',),
            Tab(text: 'Tab 3',),
          ],),
        ),
        body: TabBarView( // 한화면에서 탭을 스위칭하면서 여러 화면을 보여줄 수 있음(탭 별 내용)
          children: [
            Center(child: Text('Tab 1 Content'),),
            Center(child: Text('Tab 2 Content'),),
            Center(child: Text('Tab 3 Content'),),
          ],
        ),
      ),
    );
  }
}
