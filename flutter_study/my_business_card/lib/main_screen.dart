import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 자기소개의 내용을 입력 받는 컨트롤러
  TextEditingController introduceController = TextEditingController();

  // 자기소개 수정 모드 상태
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();

    // 위젯이 처음 실행될 때 호출된다.
    getIntroduceData();
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽으로 분할
              children: [
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
                GestureDetector(child: Container(
                  margin: EdgeInsets.only(right: 16, top: 16),
                  child: Icon(
                    Icons.mode_edit_outline_outlined,
                    color: isEditMode == true ? Colors.orange : Colors.teal,
                    size: 24,
                  ),
                ), onTap: () async {
                  if (isEditMode == false) {
                    setState(() { // setState를 통해 위젯을 재빌드함(업데이트)
                      isEditMode = true;
                    });
                  } else {
                    if (!introduceController.text.isEmpty) {
                      // 수정이 끝나면 저장 로직 시작
                      var sharedPref = await SharedPreferences.getInstance();
                      sharedPref.setString(
                          'introduce', introduceController.text);

                      setState(() {
                        isEditMode = false;
                      });
                    } else {
                      // snackBar 메시지로 입력값을 넣도록 알림
                      var snackBar = SnackBar(
                        content: Text('자기소개 입력 값이 비어있습니다.'),
                        duration: Duration(seconds: 3),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                maxLines: 5,
                controller: introduceController,
                enabled: isEditMode, // editMode를 통해 자기소개 입력창 활성화/비활성화 결정
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

  Future<void> getIntroduceData() async {
    // 기존에 저장된 자기소개 데이터가 있으면 가져오기
    var sharedPref = await SharedPreferences.getInstance();
    String introduceString = sharedPref.getString('introduce').toString();
    introduceController.text = introduceString ?? ""; // null 합류 연산자
  }
}
// <a href="https://www.flaticon.com/kr/free-icons/" title="정체 아이콘">정체 아이콘 제작자: Freepik - Flaticon</a>
