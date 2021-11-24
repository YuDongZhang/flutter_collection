import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection/bean/post.dart';
import 'package:flutter_collection/demo/layout_demo/post_show.dart';

class SingleChildScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
      // 显示进度条
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            //动态创建一个List<Widget>
            children: str
                .split("") //这里可以加 . 在上面加 . 测试一下
                //每一个字母都用一个Text显示,字体为原来的两倍
                .map((c) => Text(
                      c,
                      textScaleFactor: 2.0,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ListViewDemoOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("listview"),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: [
          Text('I\'m dedicating every day to you'),
          Text('Domestic life was never quite my style'),
          Center(child: Text('When you smile, you knock me out, I fall apart')),
          Container(
              color: Colors.red, child: Text('And I thought I was so smart')),
          Text("还可以这样玩 , 放不同的布局也可以"),
          // ListView(//再放list就不行
          //   children: [
          //     Text("data")
          //   ],
          // )
          Text("itemExtent：该参数如果不为null，则会强制children的“长度”为itemExtent的值；"
              "这里的“长度”是指滚动方向上子组件的长度，也就是说如果滚动方向是垂直方向，"
              "则itemExtent代表子组件的高度；如果滚动方向为水平方向，"
              "则itemExtent就代表子组件的宽度。在ListView中，指定itemExtent比让子组件自己决定自身长度会更高效，"
              "这是因为指定itemExtent后，滚动系统可以提前知道列表的长度，而无需每次构建子组件时都去再计算一下，"
              "尤其是在滚动位置频繁变化时（滚动系统需要频繁去计算列表高度）。"),

          Text("shrinkWrap：该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。"
              "默认情况下，ListView的会在滚动方向尽可能多的占用空间。当ListView在一个无边界(滚动方向上)的容器中时，"
              "shrinkWrap必须为true。"),
          Text(
              "addAutomaticKeepAlives：该属性表示是否将列表项（子组件）包裹在AutomaticKeepAlive 组件中；"
              "典型地，在一个懒加载列表中，如果将列表项包裹在AutomaticKeepAlive中，在该列表项滑出视口时它也不会被GC（垃圾回收），"
              "它会使用KeepAliveNotification来保存其状态。如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。"),
          Text(
              "addRepaintBoundaries：该属性表示是否将列表项（子组件）包裹在RepaintBoundary组件中。当可滚动组件滚动时，"
              "将列表项包裹在RepaintBoundary中可以避免列表项重绘，但是当列表项重绘的开销非常小（如一个颜色块，或者一个较短的文本）时，"
              "不添加RepaintBoundary反而会更高效。和addAutomaticKeepAlive一样，如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。")
        ],
      ),
    );
  }
}

class ListViewDemoTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListViewTwo"),
      ),
      body: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          }),
    );
  }
}

class ListViewDemoThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //下划线widget预定义以供复用。
    Widget divider1 = Divider(
      color: Colors.red,
    );
    Widget divider2 = Divider(color: Colors.green);

    return Scaffold(
      appBar: AppBar(
        title: Text("ListView.separated"),
      ),
      body: ListView.separated(
        itemCount: 100,
        //列表项构造器
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("$index"));
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
      ),
    );
  }
}


class ListViewDemoFour extends StatelessWidget {
  Widget _listItemBuilder(BuildContext context, int index) {
    // return Text(posts[index].title);
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(posts[index].imageUrl, fit: BoxFit.cover),
              ),
              SizedBox(height: 16.0),
              Text(posts[index].title,
                  style: Theme.of(context).textTheme.title),
              Text(posts[index].author,
                  style: Theme.of(context).textTheme.subhead),
              SizedBox(height: 16.0),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(//渐墨 效果
                  splashColor: Colors.white.withOpacity(0.3),
                  highlightColor: Colors.white.withOpacity(0.1),//高亮
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => PostShow(post: posts[index]))
                    );
                  }),
            ),
          ),
        ],
      ),

      // Column(
      //   //这个表示是竖向的
      //   children: [
      //     Image.network(posts[index].imageUrl),
      //     SizedBox(
      //       height: 16.0,
      //     ),
      //     Text(
      //       posts[index].title,
      //       style: Theme.of(context).textTheme.title,
      //     ),
      //     Text(
      //       posts[index].author,
      //       style: Theme.of(context).textTheme.subtitle1,
      //     ),
      //     SizedBox(height: 16.0,)
      //   ],
      // ),

    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemBuilder: _listItemBuilder,
      itemCount: posts.length,
    );
  }
}

