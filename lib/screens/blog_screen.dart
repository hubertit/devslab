import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget{
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Blog screen"),
      ),
    );
  }
}