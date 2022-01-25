import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reading/database/db_helper.dart';
import 'package:reading/helper/http.dart';
import 'package:reading/models/article.dart';
import 'package:reading/pages/details_page.dart';

class ArticleList extends StatefulWidget {
  final List<Article> arts;
  final bool isFav;
  const ArticleList({Key? key, required this.arts, required this.isFav})
      : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  DbHelper dbHelper = DbHelper();
  List<Article> article = [];
  List<Article> articles = [];
  String url = "http://localhost:8080/api/v1/photo/";
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    // fetchPhoto();
    super.initState();
    fetchArticle();
    fetch();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  void fetchArticle() async {
    var articles = await dbHelper.getArticles();
    if (widget.isFav) {
      setState(() {
        article = articles;
      });
    }
  }

  void refreshArticle() async {
    articles = await HTTP.httpGet(url: 'http://localhost:8080/api/v1/article/');
    setState(() {});
  }

  void fetch() async {
    var arts = await HTTP.httpGet(url: 'http://localhost:8080/api/v1/article/');
    setState(() {
      articles = arts;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.isFav ? 'Your Favourite' : 'All Articles')),
      backgroundColor: widget.isFav && article.isEmpty
          ? Colors.white
          : const Color.fromRGBO(244, 244, 244, 1),
      body: article.isEmpty && widget.isFav
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation/no_data.json',
                    width: size.width * 0.5, height: size.width * 0.5),
                Text(
                  'Don\'t have any favorite article',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ))
          : SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                if (!widget.isFav) {
                  refreshArticle();
                  refreshController.refreshCompleted();
                } else {
                  refreshController.refreshCompleted();
                }
              },
              child: ListView.builder(
                  itemCount: widget.isFav ? article.length : articles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    article: widget.isFav
                                        ? article[index]
                                        : widget.arts[index])));
                      },
                      title: Dismissible(
                        key: Key(widget.isFav
                            ? article[index].title
                            : articles[index].title),
                        direction: widget.isFav
                            ? DismissDirection.endToStart
                            : DismissDirection.none,
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            dbHelper.delete(article[index]);
                            // print('article removed');
                            article.removeAt(index);
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(size.width * 0.038),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(size.width * 0.038),
                                width: size.width * 0.25,
                                height: size.width * 0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: -5,
                                          offset: Offset(0, 5))
                                    ],
                                    image: DecorationImage(
                                        image: AssetImage(widget.isFav
                                            ? article[index].image
                                            : articles[index].image),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: size.width * 0.038,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.width * 0.05,
                                  ),
                                  Text(
                                    widget.isFav
                                        ? article[index].title
                                        : articles[index].title,
                                    style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: size.width * 0.03,
                                  ),
                                  Text(
                                    "Rate: ${widget.isFav ? article[index].rated : articles[index].rated}",
                                    style: GoogleFonts.lato(fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: size.width * 0.038,
                                  ),
                                  widget.isFav
                                      ? Text(
                                          'Swipe to left to remove from favorite',
                                          style: GoogleFonts.lato(
                                              color: Colors.grey, fontSize: 10),
                                        )
                                      : const SizedBox()
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
