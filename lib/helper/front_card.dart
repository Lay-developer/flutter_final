import 'package:flutter/material.dart';
import 'package:reading/models/article.dart';

class FrontCard extends StatelessWidget {
  final Article article;
  const FrontCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(article.title),
    );
  }
}
