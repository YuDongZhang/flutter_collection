import 'package:flutter/material.dart';
import 'dart:math' as math;

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

/*
fromLTRB(double left, double top, double right, double bottom)：分别指定四个方向的填充。
all(double value) : 所有方向均使用相同数值的填充。
only({left, top, right ,bottom })：可以设置具体某个方向的填充(可以同时指定多个方向)。
symmetric({ vertical, horizontal })：用于设置对称方向的填充，vertical指top和bottom，horizontal指left和right。
 */

class PaddingTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Padding'),
      ),
      body: Padding(
      //上下左右各添加16像素补白
      padding: EdgeInsets.all(16.0),
      child: Column(
        //显式指定对齐方式为左对齐，排除对齐干扰
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            //左边添加8像素补白
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Hello world",
            ),
          ),
          Padding(
            //上下各添加8像素补白
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("I am Jack"),
          ),
          Padding(
            // 分别指定四个方向的补白
            padding: const EdgeInsets.fromLTRB(20.0, .0, 20.0, 20.0),
            child: Text("Your friend"),
          )
        ],
      )
      ),
    );
  }
}

//这应该是使用的问题
class ConstrainedBoxDemo extends StatelessWidget {
  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar( 
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('ConstrainedBox'),
      ),
      body: Column( 
        children: [
          /*
        我们虽然将Container的高度设置为5像素，但是最终却是50像素，这正是ConstrainedBox的最小高度限制生效了。如果将Container的高度设置为80像素，
        那么最终红色区域的高度也会是80像素，因为在此示例中，ConstrainedBox只限制了最小高度，并未限制最大高度。
         */
        ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: double.infinity, //宽度尽可能大
              minHeight: 50.0 //最小高度为50像素
              ),
          child: Container(height: 5.0, child: redBox),
        ),
        SizedBox(width: 80.0, height: 80.0, child: redBox),
        //如果某一个组件有多个父级ConstrainedBox限制
        //我们发现有多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的。实际上，只有这样才能保证父限制与子限制不冲突。
        ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0), //父
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
              child: redBox,
            )),
        //UnconstrainedBox不会对子组件产生任何限制，它允许其子组件按照其本身大小绘制。一般情况下，我们会很少直接使用此组件，但在"去除"多重限制的时候也许会有帮助，
        // 我们看下下面的代码：
        // 如果没有中间的UnconstrainedBox，那么根据上面所述的多重限制规则，那么最终将显示一个90×100的红色框。但是由于UnconstrainedBox “去除”了父ConstrainedBox的限制，则最终会按照子ConstrainedBox的限制来绘制redBox，即90×20：
        ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0), //父
            child: UnconstrainedBox(
              //“去除”父级限制
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
                //子
                child: redBox,
              ),
            )),
        //在实际开发中，当我们发现已经使用SizedBox或ConstrainedBox给子元素指定了宽高，但是仍然没有效果时，几乎可以断定：已经有父元素已经设置了限制！举个例子，如Material组件库中的AppBar（导航栏）的右侧菜单中，我们使用SizedBox指定了loading按钮的大小，代码如下：
        AppBar(
          title: Text("title"),
          actions: <Widget>[
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            )
          ],
        ),
        //我们会发现右侧loading按钮大小并没有发生变化！这正是因为AppBar中已经指定了actions按钮的限制条件，所以我们要自定义loading按钮大小，就必须通过UnconstrainedBox来“去除”父元素的限制，代码如下：
        AppBar(
          title: Text("title"),
          actions: <Widget>[
            UnconstrainedBox(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(Colors.white70),
                ),
              ),
            )
          ],
        )
      ],
      )
    );
  }
}

//
class DecoratedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),  
        title: Text("装饰容器DecoratedBox"),
      ),
      body: Column(
        children: [
          DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
                  //背景渐变
                  borderRadius: BorderRadius.circular(3.0),
                  //3像素圆角
                  boxShadow: [
                    //阴影
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0)
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              )),
          Text("decoration：代表将要绘制的装饰，它的类型为Decoration。Decoration是一个抽象类，"
              "它定义了一个接口 createBoxPainter()，子类的主要职责是需要通过实现它来创建一个画笔，"
              "该画笔用于绘制装饰。"
              "position：此属性决定在哪里绘制Decoration，"
              "它接收DecorationPosition的枚举类型，该枚举类有两个值：background：在子组件之后绘制，"
              "即背景装饰。"
              "foreground：在子组件之上绘制，即前景。"),
          DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
                  //背景渐变
                  borderRadius: BorderRadius.circular(3.0),
                  //3像素圆角
                  boxShadow: [
                    //阴影
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0)
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              )),
          Text('''Color color, //颜色
    DecorationImage image,//图片
    BoxBorder border, //边框
    BorderRadiusGeometry borderRadius, //圆角
    List<BoxShadow> boxShadow, //阴影,可以指定多个
    Gradient gradient, //渐变
    BlendMode backgroundBlendMode, //背景混合模式
    BoxShape shape = BoxShape.rectangle,'''),
        ],
      ),
    );
  }
}

class TransformDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('测试'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            color: Colors.black,
            child: Transform(
              alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
              transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
              child: new Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.deepOrange,
                child: const Text('Apartment for rent!'),
              ),
            ),
          ),
          Text("平移 Transform.translate接收一个offset参数，可以在绘制时沿x、y轴对子组件平移指定的距离。 "),
          SizedBox(
            height: 50,
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            //默认原点为左上角，左移20像素，向上平移5像素
            child: Transform.translate(
              offset: Offset(-20.0, -5.0),
              child: Text("Hello world"),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text("Transform.rotate可以对子组件进行旋转变换，如："),
          SizedBox(
            height: 50,
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.rotate(
              //旋转90度
              angle: math.pi / 2,
              child: Text("Hello world"),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text("Transform.scale可以对子组件进行缩小或放大，如："),
          DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Transform.scale(
                  scale: 1.5, //放大到1.5倍
                  child: Text("Hello world"))),
          SizedBox(
            height: 50,
          ),
          Text(
              'Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子组件应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child:
                      Transform.scale(scale: 2.5, child: Text("Hello world"))),
              Text(
                "你好",
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              )
            ],
          )
        ],
      ),
    );
  }
}

class XContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),  
        title: Text('多功能的包含的组件'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 120.0),
        constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
        //卡片大小
        decoration: BoxDecoration(
          //背景装饰
          gradient: RadialGradient(
            //背景径向渐变
            colors: [Colors.red, Colors.orange],
            center: Alignment.topLeft,
            radius: .98,
          ),
          boxShadow: [
            //卡片阴影
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2.0, 2.0),
              blurRadius: 4.0,
            )
          ],
        ),
        transform: Matrix4.rotationZ(.2),
        //卡片倾斜变换
        alignment: Alignment.center,
        //卡片内文字居中
        child: Text(
          //卡片文字
          "5.20", style: TextStyle(color: Colors.white, fontSize: 40.0),
        ),
      ),
    );
  }
}

class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 头像
    Widget avatar = Image.asset("images/teacher.png", width: 60.0);
    return Scaffold(
      appBar: AppBar( 
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Clip'),
      ),
      body: Column(
        children: <Widget>[
          avatar, //不剪裁
          ClipOval(child: avatar), //剪裁为圆形
          ClipRRect(
            //剪裁为圆角矩形
            borderRadius: BorderRadius.circular(5.0),
            child: avatar,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5, //宽度设为原来宽度一半，另一半会溢出
                child: avatar,
              ),
              Text(
                "你好世界",
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRect(
                //将溢出部分剪裁
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5, //宽度设为原来宽度一半
                  child: avatar,
                ),
              ),
              Text("你好世界", style: TextStyle(color: Colors.green))
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: ClipRect(
                clipper: MyClipper(), //使用自定义的clipper
                child: avatar),
          )
        ],            
      ),
    );
  }
}

//自定义的裁剪
class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}

class XFittedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('FittedBox'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(children: [Text('xx' * 60)]), //文本长度超出 Row 的最大宽度会溢出
          ),
          
        ],
      ),
    );
  }
}
