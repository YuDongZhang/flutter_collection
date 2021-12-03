import 'package:flutter/material.dart';

import 'container_demo/container_demo.dart';

class OneContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("布局列表"),
      ),
      body: ListView(
        children: [
          ListItem("填充（Padding）", "Padding可以给其子节点添加填充（留白），和边距效果类似。",
              PaddingTestRoute()),
          ListItem(
              "ConstrainedBox",
              "ConstrainedBox用于对子组件添加额外的约束。例如，"
                  "如果你想让子组件的最小高度是80像素，你可以使用const BoxConstraints(minHeight: 80.0)作为子组件的约束。",
              ConstrainedBoxDemo()), //
          ListItem(
              "装饰容器DecoratedBox",
              "可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等。DecoratedBox定义如下",
              DecoratedBoxDemo()),
          ListItem(
              "变换（Transform）",
              "Transform可以在其子组件绘制时对其应用一些矩阵变换来实现一些特效。Matrix4是一个4D矩阵，通过它我们可以实现各种矩阵操作",
              TransformDemo()),
          ListItem(
              "Container",
              "DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组合的一个多功能容器，所以我们只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景",
              XContainerDemo()),
         ListItem(
              "剪裁（Clip）",
              "裁剪的函数",
              ClipTestRoute()),
         ListItem(
              "空间适配 FittedBox",
              "裁剪的函数",
              XFittedBoxDemo()),

        ],
      ),
    );
  }
}
