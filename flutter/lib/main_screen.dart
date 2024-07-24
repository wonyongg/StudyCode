import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //자기소개
  TextEditingController introduceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.account_box_rounded,
          size: 32,
        ),
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          '프로필',
          style: TextStyle(
              fontSize: 30, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity, // 좌우로 모바일 규격에 맞춰 끝까지 늘어남
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/me.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 이름 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              // 상하좌우 동일한 간격
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        '이름',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text(
                    '황원용',
                  ),
                ],
              ),
            ),
            // 나이 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              // 상하좌우 동일한 간격
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        '나이',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text(
                    '30',
                  ),
                ],
              ),
            ),
            // 취미 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              // 상하좌우 동일한 간격
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        '취미',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text(
                    '코딩',
                  ),
                ],
              ),
            ),
            // 직업 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              // 상하좌우 동일한 간격
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        '직업',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text(
                    '개발자',
                  ),
                ],
              ),
            ),
            // 학력 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              // 상하좌우 동일한 간격
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        '출신 학교',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text(
                    '세종대',
                  ),
                ],
              ),
            ),
            // MBTI 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              // 상하좌우 동일한 간격
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        'MBTI',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text(
                    'ENTP',
                  ),
                ],
              ),
            ),
            // 자기소개 입력 필드
            Container(
              margin: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                '자기소개',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                maxLines: 5,
                controller: introduceController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// <a href="https://www.flaticon.com/kr/free-icons/" title="정체 아이콘">정체 아이콘 제작자: Freepik - Flaticon</a>
