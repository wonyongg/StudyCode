import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
        title: Text(
          'Archive Idea',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return listItem(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 새 아이디어 작성 화면으로 이동
        },
        child: Image.asset(
          'assets/idea.png',
          width: 48,
          height: 48,
        ),
        backgroundColor: Colors.lightBlueAccent.withOpacity(0.7), // 투명도
      ),
    );
  }

  Widget listItem(index) {
    return Container(
      height: 82,
      margin: EdgeInsets.only(top: 16),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xffd9d9d9), width: 1),
        borderRadius: BorderRadius.circular(10),
      )),
      child: Stack(
        // column과 row는 서로가 서로에게 영향을 주지만 스택은 말그대로 쌓는 방식이기 때문에 그렇지 않다.(겹칠 수도 있음)
        alignment: Alignment.centerLeft,
        children: [
          // 아이디어 제목
          Container(
            margin: EdgeInsets.only(left: 16, bottom: 16),
            child: Text(
              '# 환경보존 문제해결 앱 아이디어',
              style: TextStyle(fontSize: 16),
            ),
          ),
          //일시
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(right: 16, bottom: 8),
              child: Text(
                '2024.08.01 09:00:00',
                style: TextStyle(color: Color(0xffaeaeae), fontSize: 10),
              ),
            ),
          ),
          //아이디어 중요도 점수(별)
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(left: 16, bottom: 8),
              child: RatingBar.builder(
                initialRating: 2,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 16,
                itemPadding: EdgeInsets.symmetric(horizontal: 0),
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                ignoreGestures: true,
                updateOnDrag: false,
                onRatingUpdate: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
