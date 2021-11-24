import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection/demo/layout_demo/FlexLayoutTestRoute.dart';
import 'package:flutter_collection/demo/layout_demo/LinearLayoutDemo.dart';
import 'package:flutter_collection/demo/layout_demo/align_demo.dart';
import 'package:flutter_collection/demo/layout_demo/chip_demo.dart';
import 'package:flutter_collection/demo/layout_demo/flow_warp_layout.dart';
import 'package:flutter_collection/demo/layout_demo/layout_demo.dart';

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("布局列表"),
      ),
      body: ListView(
        children: [
          ListItem("Column和row", "线性布局", LinearLayoutDemo()),
          ListItem("flex , expended", "弹性布局", FlexLayoutTestRoute()),
          ListItem("warp", "流失布局", ChipDemo()),
          ListItem("Stack、Positioned", "层叠布局", StackDemo()),
          ListItem("Align", "对齐与相对定位", AlignDemo()),
          ListItem("Align", "可滑动布局", AlignDemo()),
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
