import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'container_demo.dart';

class XFunctionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("布局列表"),
      ),
      body: ListView(
        children: [
          ListItem(
              "原始指针事件处理",
              "一次完整的事件分为三个阶段：手指按下、手指移动、和手指抬起，而更高级别的手势（如点击、双击、拖动等）都是基于这些原始事件的。",
              FunctionDemo()),
          ListItem(
              "手势识别",
              "一次完整的事件分为三个阶段：手指按下、手指移动、和手指抬起，而更高级别的手势（如点击、双击、拖动等）都是基于这些原始事件的。",
              GestureTest()),
          ListItem("拖动", "拖动", _Drag()),
          ListItem("单一方向的拖动", "单一方向", _DragVertical()),
          ListItem("缩放", "缩放", _Scale()),
          ListItem(
              "GestureRecognizer",
              "GestureDetector内部是使用一个或多个GestureRecognizer来识别各种手势的，而GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势，GestureDetector直接可以接收一个子widget。GestureRecognizer是一个抽象类，一种手势的识别器对应一个GestureRecognizer的子类，Flutter实现了丰富的手势识别器，我们可以直接使用",
              _GestureRecognizer()),
          ListItem("分发测试一", "HitTestBehavior", PointerDownListenerRoute()),
          ListItem("事件测试一", "Stack 的所有子组件都响应事件", StackEventTest()),
          ListItem("事件测试二", "SHitTestBehaviorTest ", HitTestBehaviorTest()),
          ListItem(
              "HitTestBlocker",
              "定义一个可以拦截 hitTest 各个过程的 HitTestBlocker 组件。 ",
              SHitTestBlockerTest()),
          ListItem("XGestureHitTestBlockerTest", "手势冲突",
              XGestureHitTestBlockerTest()),
          ListItem("XGestureHitTestBlockerTest", "手势识别的原理",
              XGestureHitTestBlockerTest()),
          ListItem("XGestureHitTestBlockerTest", "手势识别的原理",
              XGestureHitTestBlockerTest()),
          ListItem("手势竞争", "手势竞争", ListGesture()),
          ListItem("手势竞争,垂直和横向 ", "_BothDirectionTest", _BothDirectionTest()),
          ListItem(
              "多手势冲突",
              "由于手势竞争最终只有一个胜出者，所以，当我们通过一个 GestureDetector 监听多种手势时，也可能会产生冲突。假设有一个widget，它可以左右拖动，现在我们也想检测在它上面手指按下和抬起的事件，代码如下：",
              GestureConflictTestRoute()),
          ListItem(
              "通过自定义 Recognizer 解决手势冲突",
              "自定义手势识别器的方式比较麻烦，原理时当确定手势竞争胜出者时，会调用胜出者的acceptGesture 方法，表示“宣布成功”，然后会调用其它手势识别其的rejectGesture 方法，表示“宣布失败”。既然如此，我们可以自定义手势识别器（Recognizer），然后去重写它的rejectGesture 方法：在里面调用acceptGesture 方法，这就相当于它失败是强制将它也变成竞争的成功者了，这样它的回调也就会执行。",
              CustomTapGestureRecognizerTest()),
          ListItem("通知", "通知", NotificationDemo()),
          ListItem(
              "通知",
              "Notification有一个dispatch(context)方法，它是用于分发通知的，我们说过context实际上就是操作Element的一个接口，它与Element树上的节点是对应的，通知会从context对应的Element节点向上冒泡。",
              NotificationRoute()),
          ListItem("冒泡", "阻止冒泡", NotificationRoute())
        ],
      ),
    );
  }
}

/*
  position： 它是指针相对于当对于全局坐标的偏移。
  localPosition:  它是指针相对于当对于全局坐标的偏移.
  delta： 两次指针移动事件（PointerMoveEvent）的距离。
  pressure： 按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
  orientation： 指针移动方向，是一个角度值。
 */
class FunctionDemo extends StatefulWidget {
  @override
  _FunctionDemoState createState() => _FunctionDemoState();
}

class _FunctionDemoState extends State<FunctionDemo> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Listener(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 300.0,
            height: 150.0,
            child: Text(
              '${_event?.localPosition ?? ''}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPointerDown: (PointerDownEvent event) =>
              setState(() => _event = event),
          onPointerMove: (PointerMoveEvent event) =>
              setState(() => _event = event),
          onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
        ),
        //假如我们不想让某个子树响应PointerEvent的话，我们可以使用IgnorePointer和AbsorbPointer，这两个组件都能阻止子树接收指针事件，不同之处在于AbsorbPointer本身会参与命中测试，而IgnorePointer本身不会参与，这就意味着AbsorbPointer本身是可以接收指针事件的(但其子树不行)，而IgnorePointer不可以。
        Listener(
          child: AbsorbPointer(
            child: Listener(
              child: Container(
                color: Colors.red,
                width: 200.0,
                height: 100.0,
              ),
              onPointerDown: (event) => print("in"),
            ),
          ),
          onPointerDown: (event) => print("up"),
        )
      ],
    );
  }
}

class GestureTest extends StatefulWidget {
  @override
  _GestureTestState createState() => _GestureTestState();
}

class _GestureTestState extends State<GestureTest> {
  String _operation = "No Gesture detected!"; //保存事件名
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200.0,
          height: 100.0,
          child: Text(
            _operation,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        onTap: () => updateText("Tap"), //点击
        onDoubleTap: () => updateText("DoubleTap"), //双击
        onLongPress: () => updateText("LongPress"), //长按
      ),
    );
  }

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }
}

class _Drag extends StatefulWidget {
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _top = 20.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        )
      ],
    );
  }
}

class _DragVertical extends StatefulWidget {
  @override
  _DragVerticalState createState() => _DragVerticalState();
}

class _DragVerticalState extends State<_DragVertical> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //垂直方向拖动事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
          ),
        )
      ],
    );
  }
}

class _Scale extends StatefulWidget {
  const _Scale({Key? key}) : super(key: key);

  @override
  _ScaleState createState() => _ScaleState();
}

class _ScaleState extends State<_Scale> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        //指定宽度，高度自适应
        child: Image.asset("images/ic_banner_student.png", width: _width),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            //缩放倍数在0.8到10倍之间
            _width = 200 * details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

class _GestureRecognizer extends StatefulWidget {
  const _GestureRecognizer({Key? key}) : super(key: key);

  @override
  _GestureRecognizerState createState() => _GestureRecognizerState();
}

class _GestureRecognizerState extends State<_GestureRecognizer> {
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false; //变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: "你好世界"),
            TextSpan(
              text: "点我变色",
              style: TextStyle(
                fontSize: 30.0,
                color: _toggle ? Colors.blue : Colors.red,
              ),
              recognizer: _tapGestureRecognizer
                ..onTap = () {
                  setState(() {
                    _toggle = !_toggle;
                  });
                },
            ),
            TextSpan(text: "你好世界"),
          ],
        ),
      ),
    );
  }
}

//我们先来实现一个能够监听 PointerDownEvent 的组件
class PointerDownListener extends SingleChildRenderObjectWidget {
  PointerDownListener({Key? key, this.onPointerDown, Widget? child})
      : super(key: key, child: child);

  final PointerDownEventListener? onPointerDown;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderPointerDownListener()..onPointerDown = onPointerDown;

  @override
  void updateRenderObject(
      BuildContext context, RenderPointerDownListener renderObject) {
    renderObject.onPointerDown = onPointerDown;
  }
}

class RenderPointerDownListener extends RenderProxyBox {
  PointerDownEventListener? onPointerDown;

  @override
  bool hitTestSelf(Offset position) => true; //始终通过命中测试

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    //事件分发时处理事件
    if (event is PointerDownEvent) onPointerDown?.call(event);
  }
}

//因为我们让 hitTestSelf 的返回值始终为 true，所以无论子节点是否通过命中测试，
// PointerDownListener 都会通过，所以续分发事件时 handleEvent 就会被调用，
// 我们在里面判断事件类型为 PointerDownEvent 时触发回调即可，测试代码如下：
class PointerDownListenerRoute extends StatelessWidget {
  const PointerDownListenerRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PointerDownListener(
      child: Text('Click me'),
      onPointerDown: (e) => print('down'),
    );
  }
}

// Stack 的所有子组件都响应事件
class StackEventTest extends StatelessWidget {
  const StackEventTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        wChild(1),
        wChild(2),
      ],
    );
  }

  Widget wChild(int index) {
    return Listener(
      onPointerDown: (e) => print(index),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.grey,
      ),
    );
  }
}

//
class HitTestBehaviorTest extends StatelessWidget {
  const HitTestBehaviorTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        wChild(1),
        wChild(2),
      ],
    );
  }

  Widget wChild(int index) {
    return Listener(
      //behavior: HitTestBehavior.opaque, // 放开此行，点击只会输出 2
      behavior: HitTestBehavior.translucent, // 放开此行，点击会同时输出 2 和 1
      onPointerDown: (e) => print(index),
      child: SizedBox.expand(),
    );
  }
}

class AllChildrenCanResponseEvent extends StatelessWidget {
  const AllChildrenCanResponseEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(child: wChild(1, 200)),
        IgnorePointer(child: wChild(2, 200)),
      ],
    );
  }

  Widget wChild(int index, double size) {
    return Listener(
      onPointerDown: (e) => print(index),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey,
      ),
    );
  }
}

class HitTestBlocker extends SingleChildRenderObjectWidget {
  HitTestBlocker({
    Key? key,
    this.up = true,
    this.down = false,
    this.self = false,
    Widget? child,
  }) : super(key: key, child: child);

  /// up 为 true 时 , `hitTest()` 将会一直返回 false.
  final bool up;

  /// down 为 true 时, 将不会调用 `hitTestChildren()`.
  final bool down;

  /// `hitTestSelf` 的返回值
  final bool self;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderHitTestBlocker(up: up, down: down, self: self);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderHitTestBlocker renderObject) {
    renderObject
      ..up = up
      ..down = down
      ..self = self;
  }
}

class RenderHitTestBlocker extends RenderProxyBox {
  RenderHitTestBlocker({this.up = true, this.down = true, this.self = true});

  bool up;
  bool down;
  bool self;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    bool hitTestDownResult = false;

    if (!down) {
      hitTestDownResult = hitTestChildren(result, position: position);
    }

    bool pass =
        hitTestSelf(position) || (hitTestDownResult && size.contains(position));

    if (pass) {
      result.add(BoxHitTestEntry(this, position));
    }

    return !up && pass;
  }

  @override
  bool hitTestSelf(Offset position) => self;
}

class SHitTestBlockerTest extends StatelessWidget {
  const SHitTestBlockerTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HitTestBlocker(child: wChild(1, 200)),
        HitTestBlocker(child: wChild(2, 200)),
      ],
    );
  }

  Widget wChild(int index, double size) {
    return Listener(
      onPointerDown: (e) => print(index),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey,
      ),
    );
  }
}

class GestureHitTestBlockerTest extends StatelessWidget {
  const GestureHitTestBlockerTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HitTestBlocker(child: wChild(1, 200)),
        HitTestBlocker(child: wChild(2, 200)),
      ],
    );
  }

  Widget wChild(int index, double size) {
    return GestureDetector(
      // 将 Listener 换为 GestureDetector
      onTap: () => print('$index'),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey,
      ),
    );
  }
}

/*
组件只有通过命中测试才能响应事件。
一个组件是否通过命中测试取决于 hitTestChildren(...) || hitTestSelf(...) 的值。
组件树中组件的命中测试顺序是深度优先的。
组件子节点命中测试的循序是倒序的，并且一旦有一个子节点的 hitTest 返回了 true，就会终止遍历，后续子节点将没有机会参与命中测试。这个原则可以结合 Stack 组件来理解。
大多数情况下 Listener 的 HitTestBehavior 为 opaque 或 translucent 效果是相同的，只有当其子节点的 hitTest 返回为 false 时才会有区别。
HitTestBlocker 是一个很灵活的组件，我们可以通过它干涉命中测试的各个阶段。
 */

//手势冲突
class XGestureHitTestBlockerTest extends StatelessWidget {
  const XGestureHitTestBlockerTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HitTestBlocker(child: wChild(1, 200)),
        HitTestBlocker(child: wChild(2, 200)),
      ],
    );
  }

  Widget wChild(int index, double size) {
    return GestureDetector(
      // 将 Listener 换为 GestureDetector
      onTap: () => print('$index'),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey,
      ),
    );
  }
}

/*
当我们点击子组件（灰色区域）时，控制台只会打印 “1”, 并不会打印 “2”，这是因为手指抬起后，
GestureDetector1 和 GestureDetector 2 会发生竞争，判定获胜的规则是“子组件优先”，所以
GestureDetector1 获胜，因为只能有一个“竞争者”胜出，所以 GestureDetector 2 将被忽略。
这个例子中想要解决冲突的方法很简单，将 GestureDetector 换为 Listener
即可，具体原因我们在后面解释。
 */
//手势识别的原理
//手势需要看文档
class ListGesture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //GestureDetector2
      onTapUp: (x) => print("2"), // 监听父组件 tapUp 手势
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
        alignment: Alignment.center,
        child: GestureDetector(
          //GestureDetector1
          onTapUp: (x) => print("1"), // 监听子组件 tapUp 手势
          child: Container(
            width: 50,
            height: 50,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

/*
我们以拖动手势为例，同时识别水平和垂直方向的拖动手势，当用户按下手指时就会触发竞争（水平方向和垂直方向），一旦某个方向“获胜”，则直到当次拖动手势结束都会沿着该方向移动。
 */

class _BothDirectionTest extends StatefulWidget {
  @override
  _BothDirectionTestState createState() => _BothDirectionTestState();
}

class _BothDirectionTestState extends State<_BothDirectionTest> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //垂直方向拖动事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        )
      ],
    );
  }
}

class GestureConflictTestRoute extends StatefulWidget {
  @override
  _GestureConflictTestRouteState createState() =>
      _GestureConflictTestRouteState();
}

class _GestureConflictTestRouteState extends State<GestureConflictTestRoute> {
  double _left = 0.0;
  double _leftB = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //我们发现没有打印"up"，这是因为在拖动时，刚开始按下手指且没有移动时，拖动手势还没有完整的语义，此时TapDown手势胜出(win)，此时打印"down"，而拖动时，拖动手势会胜出，当手指抬起时，onHorizontalDragEnd 和 onTapUp发生了冲突，但是因为是在拖动的语义中，所以onHorizontalDragEnd胜出，所以就会打印 “onHorizontalDragEnd”。
        Positioned(
          top: 20,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //要拖动和点击的widget
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details) {
              print("onHorizontalDragEnd");
            },
            onTapDown: (details) {
              print("down");
            },
            onTapUp: (details) {
              print("up");
            },
          ),
        ),
//如果我们的代码逻辑中，对于手指按下和抬起是强依赖的，比如在一个轮播图组件中，我们希望手指按下时，暂停轮播，而抬起时恢复轮播，但是由于轮播图组件中本身可能已经处理了拖动手势（支持手动滑动切换），甚至可能也支持了缩放手势，这时我们如果在外部再用onTapDown、onTapUp来监听的话是不行的。这时我们应该怎么做？其实很简单，通过Listener监听原始指针事件就行：
        Positioned(
          top: 80.0,
          left: _leftB,
          child: Listener(
            onPointerDown: (details) {
              print("down");
            },
            onPointerUp: (details) {
              //会触发
              print("up");
            },
            child: GestureDetector(
              child: CircleAvatar(child: Text("B")),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _leftB += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                print("onHorizontalDragEnd");
              },
            ),
          ),
        ),
        //通过 Listener 解决手势冲突的原因是竞争只是针对手势的，而 Listener 是监听原始指针事件，
        // 原始指针事件并非语义话的手势，所以根本不会走手势竞争的逻辑，所以也就不会相互影响。
        // 拿上面两个 Container 嵌套的例子来说，通过Listener的解决方式为：
        Listener(
          // 将 GestureDetector 换位 Listener 即可
          onPointerUp: (x) => print("2"),
          child: Container(
            margin: EdgeInsets.only(top: 200),
            width: 200,
            height: 200,
            color: Colors.red,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => print("1"),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CustomTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    //不，我不要失败，我要成功
    //super.rejectGesture(pointer);
    //宣布成功
    super.acceptGesture(pointer);
  }
}

//创建一个新的GestureDetector，用我们自定义的 CustomTapGestureRecognizer 替换默认的
RawGestureDetector customGestureDetector({
  GestureTapCallback? onTap,
  GestureTapDownCallback? onTapDown,
  Widget? child,
}) {
  return RawGestureDetector(
    child: child,
    gestures: {
      CustomTapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<CustomTapGestureRecognizer>(
        () => CustomTapGestureRecognizer(),
        (detector) {
          detector.onTap = onTap;
        },
      )
    },
  );
}

//我们通过 RawGestureDetector 来自定义 customGestureDetector，
// GestureDetector 中也是通过 RawGestureDetector 来包装各种Recognizer 来实现的，
// 我们需要自定义哪个 Recognizer，就添加哪个即可。
class CustomTapGestureRecognizerTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return customGestureDetector(
      // 替换 GestureDetector
      onTap: () => print("2"),
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => print("1"),
          child: Container(
            width: 50,
            height: 50,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

//在 App 中，我们经常会需要一个广播机制，用以跨页面事件通知，比如一个需要登录的 App 中，页面会关注用户登录或注销事件，来进行一些状态更新。这时候，一个事件总线便会非常有用，事件总线通常实现了订阅者模式，订阅者模式包含发布者和订阅者两种角色，可以通过事件总线来触发事件和监听事件，本节我们实现一个简单的全局事件总线，我们使用单例模式，代码如下：
//订阅者回调签名
typedef void EventCallback(arg);

class EventBus {
  //私有构造函数
  EventBus._internal();

  //保存单例
  static EventBus _singleton = EventBus._internal();

  //工厂构造函数
  factory EventBus() => _singleton;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  final _emap = Map<Object, List<EventCallback>?>();

  //添加订阅者
  void on(eventName, EventCallback f) {
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(f);
  }

  //移除订阅者
  void off(eventName, [EventCallback? f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

//定义一个top-level（全局）变量，页面引入该文件后可以直接使用bus
var bus = EventBus();

//页面A中
// ...
//监听登录事件
// bus.on("login", (arg) {
// do something
// });

//登录页B中
// ...
//登录成功后触发登录事件，页面A中订阅者会被调用
// bus.emit("login", userInfo);

class NotificationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        switch (notification.runtimeType) {
          case ScrollStartNotification:
            print("开始滚动");
            break;
          case ScrollUpdateNotification:
            print("正在滚动");
            break;
          case ScrollEndNotification:
            print("滚动停止");
            break;
          case OverscrollNotification:
            print("滚动到边界");
            break;
        }

        return true;
      },
      child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("$index"),
            );
          }),
    );
  }
}

//Notification有一个dispatch(context)方法，它是用于分发通知的，我们说过context实际上就是操作Element的一个接口，
// 它与Element树上的节点是对应的，通知会从context对应的Element节点向上冒泡。

class NotificationRoute extends StatefulWidget {
  @override
  NotificationRouteState createState() {
    return NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + "  ";
        });
        return true;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//           ElevatedButton(
//           onPressed: () => MyNotification("Hi").dispatch(context),
//           child: Text("Send Notification"),
//          ),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  //按钮点击时分发通知
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text("Send Notification"),
                );
              },
            ),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}

