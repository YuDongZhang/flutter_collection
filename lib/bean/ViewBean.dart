import 'package:flutter/material.dart';
import 'package:flutter_collection/demo/ContainerDemo.dart';
import 'package:flutter_collection/demo/ThemeDemo.dart';
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
  ViewBean("学习", "学习",ContainerDemo()),
  ViewBean("布局", "各种布局",LayoutDemo()),
  ViewBean("滚动", "可以滚动的组件",ScrollDemo()),
];
