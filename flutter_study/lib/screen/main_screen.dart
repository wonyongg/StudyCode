import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인 화면입니다.'),
      ),
      body: const Column( // const로 컴파일 시 값을 결정하여 런타임 성능에 영향을 줌(불변일 경우 선언하는 것이 성능에 좋음)
        // 세로로 정렬하는 위젯
        // Center가 세로를 기준으로 하는 위젯이고, 내부에 있기 때문에 새로가 Main이 됨
        mainAxisAlignment: MainAxisAlignment.center,
        // 반대는 crossAxisAlignment(가로 기준)
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('반갑습니다.'),
          Text('저는'),
          Text('황원용입니다.'),
          Row(
            // 가로로 위젯을 쌀아서 정렬하는 위젯
            // Row가 가로를 기준으로 하는 위젯이고, 그 내부에 있기 때문에 가로가 Main이 됨
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('이것은 '),
              Text('Row 위젯 '),
              Text('테스트입니다.'),
            ],
          ),
          Row(children: [
            // Expanded는 자식 위젯을 확장하여 채워넣을 공간의 최대치를 확보함.
            // 즉, 아래 3개의 Expanded는 같은 간격으로 3개의 장원영이 한 row에 펼쳐짐
            // flex는 간격 비율의 정도를 설정할 수 있음
            Expanded(flex: 2, child: Text('장원영')),
            Expanded(child: Text('장원영')),
            Expanded(child: Text('장원영')),
          ],)
        ],
      ),
    );
  }
}
