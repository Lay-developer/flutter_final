import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reading/models/article.dart';
import 'package:reading/models/episode.dart';

import 'article_card.dart';

class ArticleCarousel extends StatefulWidget {
  const ArticleCarousel({Key? key, required this.article}) : super(key: key);
  final List<Article> article;

  @override
  _ArticleCarouselState createState() => _ArticleCarouselState();
}

class _ArticleCarouselState extends State<ArticleCarousel> {
  late PageController pageController;
  int initializePage = 1;
  @override
  void initState() {
    pageController =
        PageController(viewportFraction: 0.8, initialPage: initializePage);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: AspectRatio(
        aspectRatio: 0.85,
        child: PageView.builder(
            onPageChanged: (value) {
              initializePage = value;
            },
            controller: pageController,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.article.length,
            itemBuilder: (context, index) => buildCard(index)),
      ),
    );
  }

  Widget buildCard(int index) => AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 0;
        if (pageController.position.haveDimensions) {
          value = index - pageController.page!;
          value = (value * 0.038).clamp(-1, 1);
        }
        return AnimatedOpacity(
          opacity: initializePage == index ? 1 : 0.4,
          duration: const Duration(microseconds: 350),
          child: Transform.rotate(
            angle: pi * value,
            child: ArticleCard(article: widget.article[index]),
          ),
        );
      });
}
