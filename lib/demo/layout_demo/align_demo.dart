import 'package:flutter/material.dart';

class AlignDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Align布局",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue[50],
            child: Align(
              alignment: Alignment.topRight,
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue[50],
            child: Align(
              widthFactor: 2,
              heightFactor: 2,
              alignment: Alignment.topRight,
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue[50],
            child: Align(
              widthFactor: 2,
              heightFactor: 2,
              alignment: Alignment(2,0),//移中心点来作为便宜
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue[50],
            child: Align(
              widthFactor: 2,
              heightFactor: 2,
              alignment: FractionalOffset(0.2, 0.6),//左侧顶点作为便宜
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue[50],
            child: Center(//继承 Align
              widthFactor: 2,
              heightFactor: 2,
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
