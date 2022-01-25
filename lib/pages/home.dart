import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reading/helper/app_bar.dart';
import 'package:reading/database/db_helper.dart';
import 'package:reading/helper/carousel.dart';
import 'package:reading/helper/http.dart';
import 'package:reading/models/article.dart';
import 'package:reading/pages/details_page.dart';

import '../helper/article_card.dart';
import '../helper/list_article.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<Article> article = Article.article;
  // var articles = Article.article;
  List<Article> article = [];
  List<Article> latestArticle = [];
  List<Article> limit = [];
  List<Article> fav = [];

  bool isLoading = false;
  DbHelper dbHelper = DbHelper();

  PageController pageController = PageController(viewportFraction: 0.6);

  int currentIndex = 0;
  String url = 'http://localhost:8080/api/v1/article/rate';
  String latestUrl = 'http://localhost:8080/api/v1/article/latest';
  String limitUrl = "http://localhost:8080/api/v1/article/limit/10";

  @override
  void initState() {
    isLoading = true;
    fetchArticle();
    fetchFavorite();
    fetchLatest();
    fetchLimit();
    super.initState();
  }

  void fetchArticle() async {
    var articles = await HTTP.httpGet(url: url);
    article = articles;
  }

  void fetchFavorite() async {
    fav = await dbHelper.getArticles();
  }

  void fetchLatest() async {
    var latest = await HTTP.httpGet(url: latestUrl);
    latestArticle = latest;
    print(latestArticle);
  }

  void fetchLimit() async {
    var limitA = await HTTP.httpGet(url: limitUrl);
    limit = limitA;
  }

  void fetchByRate() async {
    var rate = await HTTP.httpGet(url: url);
    article = rate;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future.delayed(const Duration(seconds: 7), () {
      setState(() {
        isLoading = false;
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const SizedBox(),
        child: isLoading
            ? Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.amber, Colors.amber.withOpacity(0.5)]),
                ),
                child: Center(
                    child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Lottie.network(
                      'https://assets8.lottiefiles.com/packages/lf20_bqmgf5tx.json',
                      animate: true),
                )),
              )
            : Stack(
                children: [
                  Positioned(
                      top: 0,
                      child: MyAppBar(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArticleList(
                                        arts: fav,
                                        isFav: true,
                                      )));
                        },
                      )),
                  Positioned(
                    top: 180,
                    width: size.width,
                    height: size.width,
                    child: ArticleCarousel(article: article),
                  ),
                  Positioned(
                      top: size.height / 1.65,
                      left: 25,
                      right: 25,
                      // width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              latestArticle.isEmpty
                                  ? 'All Article'
                                  : 'Latest Article',
                              style: GoogleFonts.quicksand(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticleList(
                                              arts: article,
                                              isFav: false,
                                            )));
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.quicksand(),
                              ))
                        ],
                      )),
                  Positioned(
                      top: size.height / 1.72,
                      // right: 15,

                      // left: 10,
                      width: size.width,
                      height: size.height * 0.5,
                      child: SafeArea(
                        child: latestArticle.isEmpty
                            ? _buildLimitArticle(context)
                            : _buildLatest(context),
                      )),
                ],
              ),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: ListView.builder(
    //         itemCount: article.length,
    //         itemBuilder: (context, index) {
    //           return ListTile(
    //             title: Text(article[index].title),
    //           );
    //         }),
    //   ),
    // );
  }

  _buildLatest(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: latestArticle.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(article: latestArticle[index])));
            },
            child: SizedBox(
              width: size.width,
              height: size.width * 0.6,
              child: Stack(
                children: [
                  Positioned(
                    top: size.width * 0.05,
                    left: 10,
                    right: 10,
                    child: Container(
                        width: size.width * 0.9,
                        height: size.width * 0.5,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Start to read with Us',
                              style: GoogleFonts.quicksand(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: size.width * 0.6,
                              child: Text(
                                latestArticle[index].title,
                                style: GoogleFonts.quicksand(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            Container(
                              width: 45,
                              height: 75,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.orange,
                                  ),
                                  Text(latestArticle[index].rated.toString())
                                ],
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromRGBO(244, 244, 244, 1),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: -5,
                                  offset: Offset(0, 1))
                            ])),
                  ),
                  Positioned(
                      right: size.width * 0.13,
                      top: 10,
                      child: Container(
                        width: size.width * 0.25,
                        height: size.width * 0.35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: -5,
                                  offset: Offset(0, 5))
                            ],
                            image: DecorationImage(
                                image: AssetImage(latestArticle[index].image),
                                fit: BoxFit.cover)),
                      )),
                  Positioned(
                    bottom: 4,
                    right: 25,
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.3,
                      height: size.width * 0.13,
                      decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              topLeft: Radius.circular(25))),
                      child: Text('Read Now',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _buildLimitArticle(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: limit.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(article: limit[index])));
            },
            child: SizedBox(
              width: size.width,
              height: size.width * 0.6,
              child: Stack(
                children: [
                  Positioned(
                    top: size.width * 0.05,
                    left: 10,
                    right: 10,
                    child: Container(
                        width: size.width * 0.9,
                        height: size.width * 0.5,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Start to read with Us',
                              style: GoogleFonts.quicksand(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: size.width * 0.6,
                              child: Text(
                                limit[index].title,
                                style: GoogleFonts.quicksand(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            Container(
                              width: 45,
                              height: 75,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.orange,
                                  ),
                                  Text(limit[index].rated.toString())
                                ],
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromRGBO(244, 244, 244, 1),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: -5,
                                  offset: Offset(0, 1))
                            ])),
                  ),
                  Positioned(
                      right: size.width * 0.13,
                      top: 10,
                      child: Container(
                        width: size.width * 0.25,
                        height: size.width * 0.35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: -5,
                                  offset: Offset(0, 5))
                            ],
                            image: DecorationImage(
                                image: AssetImage(limit[index].image),
                                fit: BoxFit.cover)),
                      )),
                  Positioned(
                    bottom: 4,
                    right: 25,
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.3,
                      height: size.width * 0.13,
                      decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              topLeft: Radius.circular(25))),
                      child: Text('Read Now',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class ArticleView extends StatelessWidget {
  const ArticleView({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ArticleCard(
            article: article,
          ),
        ],
      ),
    );
  }
}
