import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,//主轴
        // crossAxisAlignment: CrossAxisAlignment.center, //交叉轴
        children: [
          ConstrainedBoxDemo()
        ],
      ),
    );
  }
}

/// 对于内部部件显示 ,子部件 最大和最小
class ConstrainedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(//限制
        minHeight: 200.0,
        maxWidth: 200.0,
      ),
      child: Container(
        color: Color.fromRGBO(3, 54, 255, 1.0),
      ),
    );
  }
}

/// AspectRatio 子部件的宽高的比例
class AspectRatioDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Container(
        color: Color.fromRGBO(3, 54, 255, 1.0),
      ),
    );
  }
}


class StackDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.topLeft,
      children: [
        SizedBox(
          width: 200.0,
          height: 300.0,
          child: Container(
            // alignment: Alignment(0.0,-1),//矩形内部的点 , 可以来控制子部件的 位置
            alignment: Alignment.topCenter, //矩形内部的点 , 可以来控制子部件的 位置
            decoration: BoxDecoration(
                color: Color.fromRGBO(3, 54, 255, 1.0),
                borderRadius: BorderRadius.circular(8.0)),
            // child: Icon(Icons.ac_unit,color: Colors.white,size: 32,),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        SizedBox(
          width: 100.0,
          height: 100.0,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(3, 54, 255, 1.0),
              // borderRadius: BorderRadius.circular(8.0)
              shape: BoxShape.circle,
              gradient: RadialGradient(colors: [
                Color.fromRGBO(7, 102, 255, 1.0),
                Color.fromRGBO(3, 54, 255, 1.0),
              ]),
            ),
            child: Icon(
              Icons.brightness_2,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        Positioned(
          right: 20.0,
          top: 20.0,
          child: Icon(Icons.ac_unit, color: Colors.white, size: 16.0),
        ),
        Positioned(
          right: 40.0,
          top: 60.0,
          child: Icon(Icons.ac_unit, color: Colors.white, size: 18.0),
        ),
        Positioned(
          right: 20.0,
          top: 120.0,
          child: Icon(Icons.ac_unit, color: Colors.white, size: 20.0),
        ),
        Positioned(
          right: 70.0,
          top: 180.0,
          child: Icon(Icons.ac_unit, color: Colors.white, size: 16.0),
        ),
        Positioned(
          right: 30.0,
          top: 230.0,
          child: Icon(Icons.ac_unit, color: Colors.white, size: 18.0),
        ),
        Positioned(
          right: 90.0,
          bottom: 20.0,
          child: Icon(Icons.ac_unit, color: Colors.white, size: 16.0),
        ),
        Positioned(
          right: 4.0,
          bottom: -4.0,
          child: Icon(Icons.ac_unit, color: Colors.white, size: 16.0),
        ),
      ],
    );

  }

}


class IconBadge extends StatelessWidget {
  final IconData icon;
  final double size;

  IconBadge(this.icon, {this.size = 32.0}); //这种就是有默认值的 size

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
      width: size + 60,
      height: size + 60,
      color: Color.fromRGBO(3, 54, 255, 1.0),
    );
  }
}
