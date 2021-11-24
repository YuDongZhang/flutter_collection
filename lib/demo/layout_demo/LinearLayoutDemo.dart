import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection/main.dart';

class LinearLayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Column"),
      ),
      body: Column(
        children: <Widget>[
          Text("column"),
          Column(
            //布局为垂直方向 , 主轴就是垂直方向, 纵轴则相反
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              Container(color: Colors.blue, child: Text("column纵向会全部占满,横向取最大子控件的宽度")),
              Text("mainAxisAlignment主轴对齐"),
              Text("crossAxisAlignment纵轴对齐"),
              Text("verticalDirection排序方向"),
              Row()
            ],
          ),
          SizedBox(height: 20,),
          Text("Row"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("data"),
              Text("datadata"),
              Container(color:Colors.greenAccent,height:40,child: Text("datadatadatadata")),
            ],
          ),
        ],
      ),
    );
  }
}
