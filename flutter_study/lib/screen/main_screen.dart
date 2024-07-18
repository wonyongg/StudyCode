import 'package:flutter/cupertino.dart';
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
      body: Column(
        // const로 컴파일 시 값을 결정하여 런타임 성능에 영향을 줌(불변일 경우 선언하는 것이 성능에 좋음), 선언과 동시에 초기화 필요.
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
          Row(
            children: [
              // Expanded는 자식 위젯을 확장하여 채워넣을 공간의 최대치를 확보함.
              // 즉, 아래 3개의 Expanded는 같은 간격으로 3개의 장원영이 한 row에 펼쳐짐
              // flex는 간격 비율의 정도를 설정할 수 있음
              Expanded(flex: 2, child: Text('장원영')),
              Expanded(child: Text('장원영')),
              Expanded(child: Text('장원영')),
            ],
          ),
          Container(
            width: 300,
            height: 100,
            // margin: EdgeInsets.all(30), // 컨테이너 외부 화면의 여백
            margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            // 컨테이너 외부 화면의 여백
            alignment: Alignment.center,
            // 컨테이너 기준 정렬
            child: Text('컨테이너입니다.'),
            // color: Colors.blue,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlueAccent,
            ),
          ),
          SizedBox(
            // 컨테이너의 기능에서 시이즈 값만 사용하는 경우
            width: 400,
            height: 50,
            child: Text(
              "사이드 박스입니다.",
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Row( // cmd + enter wrap with row
            children: [
              Image.asset('assets/car.png', width: 100, height: 100,), // https://www.flaticon.com/
              Icon(Icons.home, size: 100,),
            ],
          )
        ],
      ),
    );
  }
}
