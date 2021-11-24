import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection/demo/layout_demo/scroll_layout_demo.dart';

class ScrollDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("布局列表"),
      ),
      body: ListView(//Expanded可以用这个进行包裹
        children: [
          ListItem("SingleChildScrollView", "类似于Android中的ScrollView，它只能接收一个子组件",
              SingleChildScrollViewTestRoute()),
          ListItem("listviewOnew", "可以滑动的", ListViewDemoOne()),
          ListItem("listviewDemoTwo", "listviwe", ListViewDemoTwo()),
          ListItem(
              "ListView.separated",
              "ListView.separated可以在生成的列表项之间添加一个分割组件，"
                  "它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器。",
              ListViewDemoThree()),
          ListItem("listviewDemoFour", "listviwe", ListViewDemoFour()),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget page;

  ListItem(this.title, this.subTitle, this.page);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
