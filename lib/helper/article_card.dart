import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:reading/helper/shape.dart';
import 'package:reading/helper/variable.dart';
import 'package:reading/models/episode.dart';
import 'package:reading/pages/home.dart';
import 'package:reading/models/article.dart';
import 'package:reading/pages/details_page.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    init(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(article: article)));
      },
      child: Stack(
        children: [
          Positioned(
            top: size.width * 0.15,
            left: 0,
            child: Container(
              width: size.width * 0.6,
              height: size.width * 0.6,
              // margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: size.width * 0.10,
                    ),
                    Text(
                      article.title,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   // article.author,
                    //   style: GoogleFonts.lato(color: Colors.grey.shade700),
                    // ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            color: Colors.grey.shade200,
                            width: size.width * 0.20,
                            height: size.width * 0.12,
                            alignment: Alignment.center,
                            child: Text('Details',
                                style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                        GestureDetector(
                          child: Container(
                            width: size.width * 0.30,
                            height: size.width * 0.12,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                            child: Text(
                              'Read',
                              style: GoogleFonts.quicksand(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              right: size.width * 0.3,
              top: size.width * 0.20,
              child: Column(
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    color: Colors.black87,
                  )
                ],
              )),
          Positioned(
              right: size.width * 0.28,
              top: size.width * 0.30,
              child: Column(
                children: [
                  Container(
                    // padding: EdgeInsets.all(10),
                    width: 30,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 15,
                            spreadRadius: -10,
                            offset: Offset(5, 1))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 13,
                          height: 13,
                          color: Colors.orange,
                        ),
                        Text(
                          article.rated.toString(),
                          style: GoogleFonts.lato(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              )),
          Positioned(
              width: mainWidth * 0.3,
              top: 0,
              left: size.width * 0.05,
              child: Container(
                width: size.width * 0.3,
                height: size.width * 0.4,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: -5,
                          offset: Offset(1, 5))
                    ],
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(article.image), fit: BoxFit.cover)),
              )),
        ],
      ),
    );
  }
}


// return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: SizedBox(
    //     width: size.width * 0.60,
    //     child: AspectRatio(
    //       aspectRatio: 0.83,
    //       child: Stack(alignment: Alignment.bottomCenter, children: [
    //         Container(
    //             // color: Colors.blue,
    //             ),
    //         ClipPath(
    //           clipper: ArticleCustomShape(),
    //           child: AspectRatio(
    //             aspectRatio: 1.025,
    //             child: Container(
    //               padding: const EdgeInsets.all(20),
    //               decoration: BoxDecoration(
    //                   color: Colors.grey.shade100,
    //                   boxShadow: const [
    //                     BoxShadow(
    //                         blurRadius: 10,
    //                         spreadRadius: -1,
    //                         offset: Offset(1, 5))
    //                   ]),
    //               child: Stack(
    //                 alignment: Alignment.center,
    //                 children: [
    //                   // Positioned(child: ),
    //                   Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       SizedBox(
    //                         height: MediaQuery.of(context).size.width * 0.25,
    //                       ),
    //                       Text(
    //                         article.title,
    //                         style: const TextStyle(color: Colors.black),
    //                       ),
    //                       const SizedBox(
    //                         height: 15,
    //                       ),
    //                       Text(
    //                         article.title,
    //                         style: const TextStyle(color: Colors.black),
    //                       )
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //             top: 0,
    //             left: 0,
    //             right: 0,
    //             child: AspectRatio(
    //               aspectRatio: 1.15,
    //               child: Image.asset(
    //                 article.image,
    //                 fit: BoxFit.cover,
    //               ),
    //             )),
    //       ]),
    //     ),
    //   ),
    // );