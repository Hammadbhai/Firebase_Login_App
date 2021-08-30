import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final Map data;
  Post({this.data});

  const Post({Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          Container(
            child: Image.network(widget.data["url"]),
          ),
          Text(widget.data["title"]),
          Text(widget.data["Description"]),
        ],
      ),
    );
  }
}
