import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reading/database/db_helper.dart';
import 'package:reading/helper/http.dart';
import 'package:reading/helper/n_collection.dart';
import 'package:reading/models/article.dart';
import 'package:reading/models/photo.dart';

import 'episode_details.dart';

class DetailPage extends StatefulWidget {
  final Article article;

  const DetailPage({Key? key, required this.article}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String url = 'http://localhost:8080/api/v1/photo/';
  List<PhotoD> photo = [];
  DbHelper dbHelper = DbHelper();
  @override
  void initState() {
    fetchPhoto();
    super.initState();
  }

  void fetchPhoto() async {
    var photos = await HTTP.httpGetPhoto(url: url);
    photo = photos;
  }

  void favorite(NCollection<Article> articles) async {
    for (var item in articles.allItems) {
      widget.article.isFav = await dbHelper.selectArticleByID(item);
    }
    articles.notifyDecendant();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
      // body: Stack(
      //   children: [
      //     Positioned(
      //       top: -size.width * 0.2,
      //       left: 0,
      //       child: Opacity(
      //         opacity: 0.2,
      //         child: Container(
      //           width: size.width,
      //           height: size.height * 0.5,
      //           decoration: BoxDecoration(
      //               borderRadius: const BorderRadius.only(
      //                   bottomLeft: Radius.circular(40),
      //                   bottomRight: Radius.circular(40)),
      //               image: DecorationImage(
      //                   image: NetworkImage(
      //                     widget.article.image,
      //                   ),
      //                   fit: BoxFit.cover)),
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //         right: size.width * 0.09,
      //         top: size.width * 0.58,
      //         width: size.width * 0.3,
      //         child:
      //             Image.network(widget.article.heroImage, fit: BoxFit.cover)),
      //     Positioned(
      //         top: size.width * 0.28,
      //         left: size.width * 0.1,
      //         child: Text(
      //           widget.article.title,
      //           style: GoogleFonts.lato(
      //             fontSize: 32,
      //           ),
      //           textAlign: TextAlign.start,
      //         )),
      //     Positioned(
      //         top: size.width * 0.45,
      //         left: size.width * 0.60,
      //         child: Container(
      //           width: 13,
      //           height: 13,
      //           color: Colors.black87,
      //         )),
      //     Positioned(
      //         top: size.width * 0.2,
      //         right: size.width * 0.10,
      //         child: Container(
      //           width: 40,
      //           height: 65,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(20),
      //               color: Colors.white),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               Container(
      //                 width: 15,
      //                 height: 15,
      //                 color: Colors.orange,
      //               ),
      //               Text(
      //                 '4.8',
      //                 style: GoogleFonts.lato(),
      //               )
      //             ],
      //           ),
      //         )),
      //     Positioned(
      //         top: size.width * 0.10,
      //         left: 10,
      //         child: Container(
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(15),
      //               color: Colors.white.withOpacity(0.3)),
      //           child: IconButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               icon: const Icon(Icons.arrow_back_ios_new)),
      //         )),
      //     Positioned(
      //       top: size.width * 0.40,
      //       left: size.width * 0.09,
      //       child: SizedBox(
      //         width: size.width * 0.4,
      //         height: size.width * 0.5,
      //         child: Text(
      //           widget.article.shortDescription,
      //           style: GoogleFonts.quicksand(
      //             fontSize: 10,
      //           ),
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //         top: size.width * 0.42,
      //         right: size.width * 0.05,
      //         child: GestureDetector(
      //           onTap: () {
      //             dbHelper.addArticle(widget.article);
      //             setState(() {});
      //           },
      //           child: Container(
      //             width: size.width * 0.25,
      //             color: Colors.white,
      //             padding: const EdgeInsets.all(8),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
      //               children: [
      //                 Text('Add to favorite',
      //                     style: GoogleFonts.quicksand(
      //                       fontSize: 8,
      //                       fontWeight: FontWeight.bold,
      //                     )),
      //                 const Icon(
      //                   Icons.favorite_border_outlined,
      //                   size: 15,
      //                 )
      //               ],
      //             ),
      //           ),
      //         )),
      //     Positioned(
      //         top: size.width * 0.65,
      //         width: size.width,
      //         height: size.height * 0.7,
      //         child: ListView.builder(
      //             itemCount: widget.article.episode.length,
      //             itemBuilder: (context, index) {
      //               var ep = widget.article.episode[index];
      //               return Container(
      //                 // alignment: Alignment.centerLeft,
      //                 padding:
      //                     const EdgeInsets.only(left: 20, top: 8, bottom: 8),
      //                 margin: const EdgeInsets.only(
      //                     left: 20, right: 20, bottom: 10),
      //                 decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.circular(40)),
      //                 child: ListTile(
      //                   onTap: () {
      //                     Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => EpisodeDetails(
      //                                   episode: ep,
      //                                 )));
      //                   },
      //                   trailing: const Icon(Icons.arrow_forward_ios_outlined),
      //                   title: Column(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         'Episode ${ep.episodeNumber} : ${ep.episodeTitle}',
      //                         style: GoogleFonts.quicksand(
      //                             color: Colors.black,
      //                             fontSize: 16,
      //                             fontWeight: FontWeight.bold),
      //                       ),
      //                       Text(
      //                         ep.shortDescription,
      //                         style: GoogleFonts.lato(
      //                             color: Colors.grey.withOpacity(0.8)),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             })),
      //     Positioned(
      //         width: size.width,
      //         height: size.width * 0.45,
      //         top: size.height * 0.9,
      //         child: ListView.builder(
      //             scrollDirection: Axis.horizontal,
      //             itemCount: widget.article.character.length,
      //             itemBuilder: (context, index) {
      //               return Container(
      //                 width: size.width * 0.28,
      //                 height: size.width * 0.35,
      //                 padding: const EdgeInsets.all(15),
      //                 margin: const EdgeInsets.all(8),
      //                 decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius:
      //                         BorderRadius.circular(size.width * 0.05),
      //                     boxShadow: const [
      //                       BoxShadow(
      //                           blurRadius: 8,
      //                           spreadRadius: -5,
      //                           offset: Offset(0.0, 0.0))
      //                     ]),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Image.network(
      //                       widget.article.character[index].image,
      //                       fit: BoxFit.fitHeight,
      //                       filterQuality: FilterQuality.high,
      //                       width: size.width * 0.2,
      //                       height: size.width * 0.2,
      //                     ),
      //                     Text(
      //                       widget.article.character[index].name,
      //                       style: GoogleFonts.quicksand(fontSize: 12),
      //                     )
      //                   ],
      //                 ),
      //               );
      //             }))
      //   ],
      // ),
      // body: Column(
      //   children: [
      //     Opacity(
      //       opacity: 0.3,
      //       child: Container(
      //         height: size.height * 0.4,
      //         width: size.width,
      //         alignment: Alignment.centerLeft,
      //         decoration: BoxDecoration(
      //             image: DecorationImage(
      //                 image: NetworkImage(widget.article.image),
      //                 fit: BoxFit.cover),
      //             borderRadius: BorderRadius.circular(45)),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             SizedBox(
      //               height: size.width * 0.12,
      //             ),
      //             Container(
      //               width: 45,
      //               height: 45,
      //               margin: const EdgeInsets.only(left: 10),
      //               decoration: BoxDecoration(
      //                   color: Colors.grey,
      //                   borderRadius: BorderRadius.circular(15)),
      //               child: IconButton(
      //                 onPressed: () {
      //                   Navigator.pop(context);
      //                 },
      //                 icon: const Icon(
      //                   Icons.arrow_back_ios_new_outlined,
      //                   color: Colors.black,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       width: size.width,
      //       height: size.height - size.height * 0.4,
      //       child: ListView(
      //         children: [
      //           SizedBox(
      //             width: size.width,
      //             height: size.height - size.height * 0.4,
      //             child: Expanded(
      //                 child: ListView.builder(
      //                     itemCount: widget.article.episode.length,
      //                     itemBuilder: (context, index) {
      //                       var ep = widget.article.episode[index];
      //                       return Container(
      //                           // alignment: Alignment.centerLeft,
      //                           padding: const EdgeInsets.only(
      //                               left: 20, top: 8, bottom: 8),
      //                           margin: const EdgeInsets.only(
      //                               left: 20, right: 20, bottom: 10),
      //                           decoration: BoxDecoration(
      //                               color: Colors.white,
      //                               borderRadius: BorderRadius.circular(40)),
      //                           child: ListTile(
      //                             onTap: () {
      //                               Navigator.push(
      //                                   context,
      //                                   MaterialPageRoute(
      //                                       builder: (context) =>
      //                                           EpisodeDetails(
      //                                             episode: ep,
      //                                           )));
      //                             },
      //                             trailing: const Icon(
      //                                 Icons.arrow_forward_ios_outlined),
      //                             title: Column(
      //                               mainAxisAlignment: MainAxisAlignment.start,
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 Text(
      //                                   'Episode ${ep.episodeNumber} : ${ep.episodeTitle}',
      //                                   style: GoogleFonts.quicksand(
      //                                       color: Colors.black,
      //                                       fontSize: 16,
      //                                       fontWeight: FontWeight.bold),
      //                                 ),
      //                                 Text(
      //                                   ep.shortDescription,
      //                                   style: GoogleFonts.lato(
      //                                       color:
      //                                           Colors.grey.withOpacity(0.8)),
      //                                 )
      //                               ],
      //                             ),
      //                           ));
      //                     })),
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
      // ),

      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height * 0.4,
            top: 0,
            child: Opacity(
              opacity: 0.3,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    image: DecorationImage(
                        image: NetworkImage(widget.article.image),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.4,
            width: size.width,
            height: size.height * 0.4,
            child: SingleChildScrollView(
                child: SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.4,
                    child: ListView.builder(
                        itemCount: widget.article.episode.length,
                        itemBuilder: (context, index) {
                          var ep = widget.article.episode[index];
                          return Container(
                              //                           // alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(
                                  left: 20, top: 8, bottom: 8),
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40)),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EpisodeDetails(
                                                episode: ep,
                                              )));
                                },
                                trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Episode ${ep.episodeNumber} : ${ep.episodeTitle}',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ep.shortDescription,
                                      style: GoogleFonts.lato(
                                          color: Colors.grey.withOpacity(0.8)),
                                    )
                                  ],
                                ),
                              ));
                        }),
                  ),
                ],
              ),
            )),
          ),
          Positioned(
            top: size.height * 0.81,
            child: SizedBox(
                width: size.width,
                height: size.width * 0.38,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.article.character.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: size.width * 0.28,
                        height: size.width * 0.35,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(size.width * 0.05),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: -5,
                                  offset: Offset(0.0, 0.0))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              widget.article.character[index].image,
                              fit: BoxFit.fitHeight,
                              filterQuality: FilterQuality.high,
                              width: size.width * 0.2,
                              height: size.width * 0.2,
                            ),
                            Text(
                              widget.article.character[index].name,
                              style: GoogleFonts.quicksand(fontSize: 12),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    })),
          ),
          Positioned(
              top: size.width * 0.28,
              left: size.width * 0.1,
              child: Text(
                widget.article.title,
                style: GoogleFonts.lato(
                  fontSize: 32,
                ),
                textAlign: TextAlign.start,
              )),
          Positioned(
              top: size.width * 0.60,
              right: size.width * 0.05,
              child: Container(
                width: 40,
                height: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      color: Colors.orange,
                    ),
                    Text(
                      '4.8',
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
              )),
          Positioned(
              top: size.width * 0.10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.3)),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
              )),
          Positioned(
            top: size.width * 0.40,
            left: size.width * 0.09,
            child: SizedBox(
              width: size.width * 0.4,
              height: size.width * 0.5,
              child: Text(
                widget.article.shortDescription,
                style: GoogleFonts.quicksand(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Positioned(
              top: size.width * 0.75,
              left: size.width * 0.08,
              child: GestureDetector(
                onTap: () {
                  dbHelper.addArticle(widget.article);
                  setState(() {});
                },
                child: Container(
                  width: size.width * 0.25,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Add to favorite',
                          style: GoogleFonts.quicksand(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const Icon(
                        Icons.favorite_border_outlined,
                        size: 15,
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
