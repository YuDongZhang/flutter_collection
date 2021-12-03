import 'package:flutter/material.dart';
import 'package:flutter_collection/demo/ContainerDemo.dart';
import 'package:flutter_collection/demo/ThemeDemo.dart';
import 'package:flutter_collection/demo/animation_demo/XAnimationDemo.dart';
import 'package:flutter_collection/demo/container_demo/function_demo.dart';
import 'package:flutter_collection/demo/layout_demo/LayoutDemo.dart';
import 'package:flutter_collection/demo/layout_demo/scroll_demo.dart';

class ViewBean {

  ViewBean(this.title, this.details,this.page);

  final String title;
  final String details;
  final Widget page;
}

final List<ViewBean> viewBeans = [
  ViewBean("text", "url",ThemeDemo()),
  ViewBean("学习", "学习",OneContainerDemo()),
  ViewBean("布局", "各种布局",LayoutDemo()),
  ViewBean("滚动", "可以滚动的组件",ScrollDemo()),
  ViewBean("容器类", "可以滚动的组件",OneContainerDemo()),
  ViewBean("功能型组件", "功能型",XFunctionDemo()),
  ViewBean("动画组件", "功能型",XAnimationDemo()),
];
