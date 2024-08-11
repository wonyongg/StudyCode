import 'package:flutter/material.dart';
import 'package:my_archive_idea/data/idea_info.dart';
import 'package:my_archive_idea/screen/detail_screen.dart';
import 'package:my_archive_idea/screen/edit_screen.dart';
import 'package:my_archive_idea/screen/main_screen.dart';
import 'package:my_archive_idea/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Archive Idea',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/main': (context) => MainScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          // 아이디어 기록 값을 넘기면 수정 시나리오
          // 아이디어 기록 값을 넘기지 못하면 수정 시나리오
          // settings.arguments에서 IdeaInfo 타입의 데이터를 가져와 ideaInfo라는 변수에 할당하는 역할을 합니다.
          // 만약 settings.arguments가 IdeaInfo 타입이 아니거나 null인 경우, ideaInfo는 null이 됩니다.
          final IdeaInfo? ideaInfo = settings.arguments as IdeaInfo?;
          
          return MaterialPageRoute(builder: (context) {
            return EditScreen(ideaInfo: ideaInfo,);
          },);
        } else if (settings.name == '/detail') {
          final IdeaInfo? ideaInfo = settings.arguments as IdeaInfo?;

          return MaterialPageRoute(builder: (context) {
            return DetailScreen(ideaInfo: ideaInfo,);
          },);
        }
      },

    );
  }
}
