import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection/demo/animation_demo/animation_web.dart';

class AnimationBean {
  AnimationBean(this.title, this.details, this.page);

  final String title;
  final String details;
  final Widget page;
}

final List<AnimationBean> animationBeans = [
  AnimationBean("text", "url", AnimationWebDemo()),
];

class XAnimationDemo extends StatelessWidget {
  //这个只是一个变量
  Widget _listItemBuilder(BuildContext context, int index) {
    // return Text(posts[index].title);
    return Container(
      color: Colors.yellow,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => animationBeans[index].page),
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
              animationBeans[index].title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              animationBeans[index].details,
              style: Theme.of(context).textTheme.bodyLarge,
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("动画"),
      ),
      body: ListView.builder(
        itemBuilder: _listItemBuilder,
        itemCount: animationBeans.length,
      ),
    );
  }
}
