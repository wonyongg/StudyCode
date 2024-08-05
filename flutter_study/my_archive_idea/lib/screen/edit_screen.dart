import 'package:flutter/material.dart';

import '../data/idea_info.dart';

class EditScreen extends StatefulWidget {
  IdeaInfo? ideaInfo;

  EditScreen({super.key, this.ideaInfo});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  // 아이디어 제목
  final TextEditingController _titleController = TextEditingController();

  // 아이디어 계기
  final TextEditingController _motiveController = TextEditingController();

  // 아이디어 내용
  final TextEditingController _contentController = TextEditingController();

  // 피드백 사항
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // leading : 화면 좌측에 배치
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: Colors.black,
          ),
          onTap: () {
            // 뒤로가기
            Navigator.pop(context);
          },
        ),
        title: Text(
          '새 아이디어 작성하기',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
            children: [
              Text('제목'),
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 41,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffd9d9d9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '아이디어 제목',
                    hintStyle: TextStyle(
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  controller: _titleController,
                ),
              ),
              Text('아이디어를 떠올린 계기'),
              Text('아이디어 내용'),
              Text('아이디어를 중요도 점수'),
              Text('유저 피드백 사항 (선택)'),
            ],
          ),
        ),
      ),
    );
  }
}
