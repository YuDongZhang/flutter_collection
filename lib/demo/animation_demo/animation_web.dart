import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnimationWebDemo extends StatefulWidget {
  @override
  _AnimationWebDemoState createState() => _AnimationWebDemoState();
}

class _AnimationWebDemoState extends State<AnimationWebDemo> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器
    _controller = AnimationController(
      duration: Duration(seconds: 2),  // 动画持续2秒
      vsync: this,
    );

    // 创建一个从0.5到2.0的补间动画
    _animation = Tween<double>(begin: 0.5, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,  // 使用弹性曲线
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();  // 释放控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('动画演示'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 使用 ScaleTransition 创建缩放动画
            ScaleTransition(
              scale: _animation,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            // 添加按钮控制动画
            ElevatedButton(
              onPressed: () {
                if (_controller.status == AnimationStatus.completed) {
                  _controller.reverse();  // 如果动画完成则反向播放
                } else {
                  _controller.forward();  // 否则正向播放
                }
              },
              child: Text('播放动画'),
            ),
          ],
        ),
      ),
    );
  }
}

