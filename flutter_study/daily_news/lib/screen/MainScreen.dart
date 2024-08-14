import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> newsInfoList = [];

  @override
  void initState() {
    super.initState();

    // 뉴스 정보 가져오기
    getNewsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff424242),
        title: Text(
          '📰 뉴스 헤드라인',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: newsInfoList.length,
        itemBuilder: (context, index) {
          var newsItem = newsInfoList[index];
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // 이미지
                  Container(
                    height: 170,
                    width: double.infinity,
                    child: newsItem['urlToImage'] != null
                        ? ClipRRect(
                            child: Image.network(
                              newsItem['urlToImage'],
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          )
                        : ClipRRect(
                            child: Image.asset('assets/image.png'),
                            borderRadius: BorderRadius.circular(10),
                          ),
                  ),
                  // 반투명 검정 UI
                  Container(
                    width: double.infinity,
                    height: 57,
                    decoration: ShapeDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newsItem['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5,),
                          Align(
                            child: Text(
                              formatDate(newsItem['publishedAt']),
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            alignment: Alignment.bottomRight,
                          )
                        ],
                      ),
                    ),
                  )
                  // 하얀색 뉴스 제목, 일자, 텍스트
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: newsItem);
            },
          );
        },
      ),
    );
  }

  String formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString);
    var dateFormat = DateFormat('yyyy.MM.dd HH:mm');

    return dateFormat.format(dateTime);
  }

  Future getNewsInfo() async {
    // 뉴스 정보를 가지고 오는 api 활용
    const apiKey = 'fe9fb6ec8b194a5ba6f47664c645ebd0'; // news api key
    const apiUrl =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          newsInfoList = responseData['articles'];
        });

        // debug
        newsInfoList.forEach(
          (element) {
            print(element);
          },
        );
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      print(error);
    }
  }
}

// <a href="https://www.flaticon.com/kr/free-icons/-" title="예술과 디자인 아이콘">예술과 디자인 아이콘 제작자: mim_studio - Flaticon</a>
