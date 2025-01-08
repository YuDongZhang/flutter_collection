import 'package:flutter/material.dart';
import 'package:flutter_collection/bean/post.dart';

class PostShow extends StatelessWidget {
  final Post post;

  //构造方法中传入单个 对象
  PostShow({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('${post.title}'),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Image.network(
            post.imageUrl
          ),
          Container(
            padding: EdgeInsets.all(32.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${post.title}', style: Theme.of(context).textTheme.titleSmall),
                Text('${post.author}', style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 32.0),
                Text('${post.description}', style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}