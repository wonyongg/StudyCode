import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {

  List list = ['장원영', '안유진', '카리나', '윈터', '팜하니'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('최애 아이돌 리스트입니다.'),
      ),
      body : ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${index+1}. ${list[index]}'),
            subtitle: Text('서브타이틀입니다.'),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
