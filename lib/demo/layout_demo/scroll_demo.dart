import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection/demo/layout_demo/grid_view_demo.dart';
import 'package:flutter_collection/demo/layout_demo/scroll_layout_demo.dart';

class ScrollDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("布局列表"),
      ),
      body: ListView(
        //Expanded可以用这个进行包裹
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
          ListItem("GridView", "GridView", GridViewBuilderDemo()),
          ListItem(
              "GridViewExtenDemo", "GridViewExtenDemo", GridViewExtenDemo()),
          ListItem("GridViewCountDemo", "水平滚动", GridViewCountDemo()),
          ListItem("CustomScrollView", "可滚动的组件", SliverDemo()),
          ListItem("CustomScrollViewTestRoute", "CustomScrollViewTestRoute",
              CustomScrollViewTestRoute()),
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
