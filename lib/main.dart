import 'package:flutter/material.dart';
import 'package:flutter_collection/bean/ViewBean.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.grey,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          highlightColor: Color.fromRGBO(255, 255, 255, 0.5), //设置主题的高亮颜色
          splashColor: Colors.white70 //设置 水波纹
          ),
      home: ListViewDemo(),
    );
  }
}

class ListViewDemo extends StatelessWidget {
  //这个只是一个变量
  Widget _listItemBuilder(BuildContext context, int index) {
    // return Text(posts[index].title);
    return Container(
      color: Colors.yellow,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => viewBeans[index].page),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //这个表示是竖向的
          children: [
            SizedBox(
              height: 8.0,
            ),
            Text(
              viewBeans[index].title,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              viewBeans[index].details,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 8.0,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: _listItemBuilder,
          itemCount: viewBeans.length,
        ),
      ),
    );
  }
}
