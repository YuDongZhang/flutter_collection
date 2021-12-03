import 'package:flutter/material.dart';
import 'package:flutter_collection/bean/post.dart';

class GridViewBuilderDemo extends StatelessWidget {
  Widget _gridItemBuilder(BuildContext context, int index) {
    return Container(
      child: Image.network(posts[index].imageUrl, fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8.0), //添加了一个内边距
      itemCount: posts.length,
      itemBuilder: _gridItemBuilder,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //网格间距的设置 ///SliverGridDelegateWithFixedCrossAxisCount
        // crossAxisCount: 3, //有两种方式来设计
        maxCrossAxisExtent: 150.0,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
    );
  }
}

/*
crossAxisCount：横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，即ViewPort横轴长度除以crossAxisCount的商。
mainAxisSpacing：主轴方向的间距。
crossAxisSpacing：横轴方向子元素的间距。
childAspectRatio：子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。
 */

class GridViewExtenDemo extends StatelessWidget {
  List<Widget> _buildTiles(int length) {
    return List.generate(length, (int index) {
      return Container(
        color: Colors.grey[300],
        alignment: Alignment(0.0, 0.0),
        child: Text('Item $index',
            style: TextStyle(fontSize: 18.0, color: Colors.grey)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 200.0, //项目最大的宽度
      crossAxisSpacing: 16.0, //间隔
      mainAxisSpacing: 16.0, //竖向的间隔
      children: _buildTiles(100),
    );
  }
}

class GridViewCountDemo extends StatelessWidget {
  List<Widget> _buildTiles(int length) {
    return List.generate(length, (int index) {
      return Container(
        color: Colors.grey[300],
        alignment: Alignment(0.0, 0.0),
        child: Text('Item $index',
            style: TextStyle(fontSize: 18.0, color: Colors.grey)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      scrollDirection: Axis.horizontal,
      //水平滚动
      crossAxisSpacing: 16.0,
      //间隔
      mainAxisSpacing: 16.0,
      //竖向的间隔
      children: _buildTiles(100),
    );
  }
}

class SliverDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverPadding(padding: EdgeInsets.all(8.0),sliver: SliverGridDemo()),
          // SliverSafeArea(sliver: SliverGridDemo())//显示在安全区域 , 就是避免被刘海挡住
          SliverAppBar(
            title: Text('老张'),
            // pinned: true,//标题不会一起滚动
            floating: true, //向下拉动的时候回出来
            expandedHeight: 178.0, //伸展高度
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Ninghao Flutter'.toUpperCase(),
                style: TextStyle(
                  fontSize: 15.0, //最小尺寸
                  letterSpacing: 3.0, //最大尺寸
                  fontWeight: FontWeight.w400,
                ),
              ),
              background: Image.network(
                //背景
                'https://resources.ninghao.net/images/overkill.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverListDemo(),
            ),
          )
        ],
      ),
    );
  }
}

class SliverListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        //delegate 代表的意思
        (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 32), //只是添加底边距

            child: Material(
                borderRadius: BorderRadius.circular(12.0), //实际测试发现无效
                elevation: 14.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9, //图片的比例
                      child: Image.network(
                        posts[index].imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 32.0,
                      left: 32.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            posts[index].title,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                          Text(
                            posts[index].author,
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                )

                // Container(
                //   // width: 120,//设置了之后可以看到圆角 ,不过不是图片的
                //   // height: 60,
                //   child: Image.network(
                //     posts[index].imageUrl,
                //     fit: BoxFit.contain,
                //   ),
                //
                // ),

                ),
          );
        },
        childCount: posts.length,
      ),
    );
  }
}

class CustomScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                'images/ic_banner_student.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
              //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return new Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: new Text('list item $index'),
              );
            }, childCount: 50 //50个列表项
                ),
          ),
        ],
      ),
    );
  }
}
