import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/article_controller.dart';

class ArticleScreen extends GetView<ArticleController> {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Article')),
      body: ListView.builder(
        itemBuilder: (ctx, idx) => ListTile(title: Text('title')),
        itemCount: 20,
      ),
    );
  }
}
