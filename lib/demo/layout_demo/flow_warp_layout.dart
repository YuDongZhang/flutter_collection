import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_collection/demo/layout_demo/chip_demo.dart';

class WrapDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("warp flow"),
      ),
      body: ChipDemo(),
    );
  }
}
