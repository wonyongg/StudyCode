import 'package:flutter/material.dart';
import 'package:my_archive_idea/database/database_helper.dart';

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

  // 아이디어 중요도 점수 container 클릭 상태 관리 변수
  bool isClickPoint1 = false;
  bool isClickPoint2 = false;
  bool isClickPoint3 = true;
  bool isClickPoint4 = false;
  bool isClickPoint5 = false;

  // 아이디어 선택된 현재 중요도 점수 (default value = 3)
  int priorityPoint = 3;

  // database helper
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();

    // 기존 데이터를 수정하는 경우 수정 편의를 위해 기존 데이터를 입력 위젯에 자동 기입
    if (widget.ideaInfo != null) {
      // 입력 필드 세팅
      _titleController.text = widget.ideaInfo!.title;
      _motiveController.text = widget.ideaInfo!.motive;
      _contentController.text = widget.ideaInfo!.content;
      // 피드백 입력 필드의 경우는 옵션이기 때문에 따로 값이 비었는지 체크 필요
      if(widget.ideaInfo!.feedback.isNotEmpty) {
        _feedbackController.text = widget.ideaInfo!.feedback;
      }

      // 아이디어 중요도 점수 세팅
      initClickStatus();
      switch (widget.ideaInfo!.priority)  {
        case 1:
          isClickPoint1 = true;
          break;
        case 2:
          isClickPoint2 = true;
          break;
        case 3:
          isClickPoint3 = true;
          break;
        case 4:
          isClickPoint4 = true;
          break;
        case 5:
          isClickPoint5 = true;
          break;
      }

      priorityPoint = widget.ideaInfo!.priority;
    }
  }

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
          widget.ideaInfo == null ? '새 아이디어 작성하기' : '아이디어 편집',
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
                  textInputAction: TextInputAction.next,
                  // 키패드에서 엔터 치면 다음 text 입력창으로 넘어감
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
              SizedBox(
                height: 16,
              ),
              Text('아이디어를 떠올린 계기'),
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 41,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffd9d9d9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '아이디어를 떠올린 계기',
                    hintStyle: TextStyle(
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  controller: _motiveController,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text('아이디어 내용'),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: TextField(
                  maxLength: 500,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffd9d9d9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '떠오르신 아이디어를 자세하게 작성해주세요.',
                    hintStyle: TextStyle(
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  controller: _contentController,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text('아이디어를 중요도 점수'),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // Row 안에 간격 자동 조절
                  children: [
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        // 컨테이너 정중앙으로 위치
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                            color: isClickPoint1
                                ? Color(0xffd6d6d6)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        // 1. 모든 버튼 값 초기화
                        initClickStatus();
                        // 2. 선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 1;
                          isClickPoint1 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        // 컨테이너 정중앙으로 위치
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                            color: isClickPoint2
                                ? Color(0xffd6d6d6)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        // 1. 모든 버튼 값 초기화
                        initClickStatus();
                        // 2. 선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 2;
                          isClickPoint2 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        // 컨테이너 정중앙으로 위치
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                            color: isClickPoint3
                                ? Color(0xffd6d6d6)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        // 1. 모든 버튼 값 초기화
                        initClickStatus();
                        // 2. 선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 3;
                          isClickPoint3 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        // 컨테이너 정중앙으로 위치
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                            color: isClickPoint4
                                ? Color(0xffd6d6d6)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          '4',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        // 1. 모든 버튼 값 초기화
                        initClickStatus();
                        // 2. 선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 4;
                          isClickPoint4 = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        // 컨테이너 정중앙으로 위치
                        width: 50,
                        height: 40,
                        decoration: ShapeDecoration(
                            color: isClickPoint5
                                ? Color(0xffd6d6d6)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          '5',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        // 1. 모든 버튼 값 초기화
                        initClickStatus();
                        // 2. 선택된 버튼에 대한 변수 값 및 위젯 update
                        setState(() {
                          priorityPoint = 5;
                          isClickPoint5 = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text('유저 피드백 사항 (선택)'),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: TextField(
                  maxLength: 500,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffd9d9d9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '떠오르신 아이디어를 기반으로\n전달받은 피드백들을 정리해주세요.',
                    hintStyle: TextStyle(
                      color: Color(0xffb4b4b4),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  controller: _feedbackController,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // 아이디어 작성 완료 버튼
              GestureDetector(
                child: Container(
                  height: 65,
                  alignment: Alignment.center,
                  child: Text('아이디어 작성 완료'),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onTap: () async {
                  // 아이디어 작성 처리
                  String titleValue = _titleController.text.toString();
                  String motiveValue = _motiveController.text.toString();
                  String contentValue = _contentController.text.toString();
                  String feedbackValue = _feedbackController.text.toString();

                  // 유효성 검사(null 값 체크)
                  if (titleValue.isEmpty ||
                      motiveValue.isEmpty ||
                      contentValue.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('비어있는 입력 값이 존재합니다.'),
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }

                  // 새 아이디어를 작성하는 경우
                  if (widget.ideaInfo == null) {
                    // 아이디어 정보 클래스 인스턴스 생성 후 db 삽입
                    var ideaInfo = IdeaInfo(
                      title: titleValue,
                      motive: motiveValue,
                      content: contentValue,
                      priority: priorityPoint,
                      feedback: feedbackValue.isNotEmpty ? feedbackValue : '',
                      createdAt: DateTime.now().millisecondsSinceEpoch,
                    );

                    await setInsertIdeaInfo(ideaInfo);
                    if (mounted) {
                      // 모든 시나리오가 완료되었으니 이전 화면으로 이동
                      Navigator.pop(context, 'insert');
                    }
                  }
                  // 기존의 이아디어를 업데이트 하는 경우
                  else {
                    var ideaInfoModify = widget.ideaInfo;
                    ideaInfoModify?.title = titleValue;
                    ideaInfoModify?.motive = motiveValue;
                    ideaInfoModify?.content = contentValue;
                    ideaInfoModify?.priority = priorityPoint;
                    ideaInfoModify?.feedback = feedbackValue.isNotEmpty ? feedbackValue : '';

                    // 데이터 업데이트
                    await setUpdateIdeaInfo(ideaInfoModify!);

                    // 스크린 닫기
                    if (mounted) {
                      Navigator.pop(context, 'update');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future setInsertIdeaInfo(IdeaInfo ideaInfo) async {
    // 삽입하는 메서드
    await dbHelper.initDatabase();
    await dbHelper.insertIdeaInfo(ideaInfo);
  }

  Future setUpdateIdeaInfo(IdeaInfo ideaInfo) async {
    // 기존 아이디어 정보를 db에 업데이트 시키는 메서드
    await dbHelper.initDatabase();
    await dbHelper.updateIdeaInfo(ideaInfo);
  }

  void initClickStatus() {
    // 클릭 상태를 초기화해주는 함수
    isClickPoint1 = false;
    isClickPoint2 = false;
    isClickPoint3 = false;
    isClickPoint4 = false;
    isClickPoint5 = false;
  }
}
