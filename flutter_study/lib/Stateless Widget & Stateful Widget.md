```dart
// 위젯(widget)이란?
// - 앱의 모든 구성요소를 나타내며, 화면에 그려지는 모든 것을 표현 가능하다.
// - 다양한 종류와 계층 구조로 되어있다.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('나의 첫 앱'),), body: Text('안녕하세요!'));
  }
}
```

```dart
// Stateful Widget - 상태를 가지는 위젯이며, 사용자 상호 작용 또는 다른 이벤트에 따라 상태를 변경할 수 있다.
class MainScreen2 extends StatefulWidget {
  const MainScreen2({super.key});

  @override
  State<MainScreen2> createState() => _MainScreen2State();
}

class _MainScreen2State extends State<MainScreen2> {

  String msg = '안녕하세요!';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        msg = '반가워요!';
      });
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('나의 첫 앱'),), body: Text(msg));
  }
}
```
