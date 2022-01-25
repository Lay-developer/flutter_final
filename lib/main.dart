import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reading/pages/home.dart';
import 'package:reading/models/article.dart';

void main() {
  return runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

// class Read extends StatefulWidget {
//   Read({Key? key}) : super(key: key);

//   @override
//   State<Read> createState() => _ReadState();
// }

// class _ReadState extends State<Read> {
//   final page = [
//     Container(
//       color: Colors.amber,
//     ),
//     Container()
//   ];
//   bool isLoading = false;
//   double itemSize = 130.0;

//   /////////////
//   ///Controller
//   final ScrollController scrollController = ScrollController();

//   void onListen() {
//     print('scrolllerController: ${scrollController.offset}');
//     setState(() {});
//   }

//   // List<Article> article = [
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFF0fd412,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFF0fd4d4,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFF990fd4,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFFd40fd1,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFFd40f88,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFFd40f0f,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFFb6d40f,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFF33d40f,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFFFF9000,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFFFF9000,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFFFF9000,
//   //       image: 'assets/animation/book.json'),
//   //   Article(
//   //       id: 1,
//   //       title: 'test',
//   //       description: 'test',
//   //       color: 0xFFFF9000,
//   //       image: 'assets/animation/book.json'),
//   // ];

//   @override
//   void initState() {
//     scrollController.addListener(onListen);
//     isLoading = true;
//     article.addAll(List.from(article));
//     super.initState();
//   }

//   @override
//   void dispose() {
//     scrollController.removeListener(onListen);
//     scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 7), () {
//       setState(() {
//         isLoading = false;
//       });
//     });
//     return Scaffold(
//       body: ModalProgressHUD(
//         inAsyncCall: isLoading,
//         progressIndicator: const SizedBox(),
//         child: isLoading
//             ? Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       colors: [Colors.amber, Colors.amber.withOpacity(0.5)]),
//                 ),
//                 child: Center(
//                     child: Container(
//                   padding: const EdgeInsets.all(20),
//                   child: Lottie.network(
//                       'https://assets8.lottiefiles.com/packages/lf20_bqmgf5tx.json',
//                       animate: true),
//                 )),
//               )
//             : _buildReading(),
//       ),
//     );
//   }

//   Widget _buildReading() {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: CustomScrollView(
//         controller: scrollController,
//         slivers: <Widget>[
//           // SliverToBoxAdapter(
//           //     child: ListView.builder(
//           //         scrollDirection: Axis.horizontal,
//           //         itemCount: article.length,
//           //         itemBuilder: (context, index) {
//           //           var articles = article[index];
//           //           return Container(
//           //             child: Row(children: [
//           //               Text(articles.title),
//           //               Lottie.network(articles.image)
//           //             ]),
//           //           );
//           //         })),

//           SliverAppBar(
//             automaticallyImplyLeading: false,
//             title: Container(
//               alignment: Alignment.centerLeft,
//               child: const Text(
//                 'Article',
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//             pinned: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//           const SliverToBoxAdapter(
//             child: SizedBox(
//               height: 50,
//             ),
//           ),
//           SliverList(
//               delegate: SliverChildBuilderDelegate((context, index) {
//             final articles = article[index];
//             final itemPositionOffset = index * itemSize * 0.5;
//             final different = scrollController.offset - itemPositionOffset;
//             final percent = 1.0 - (different / itemSize * 0.5);
//             print('percent: $percent');
//             double opacity = percent;
//             double scale = percent;
//             if (percent > 1.0) scale = 1.0;
//             if (opacity > 1.0) opacity = 1;
//             if (opacity < 0.0) opacity = 0.0;
//             return Align(
//               heightFactor: 0.5,
//               child: Opacity(
//                 opacity: opacity,
//                 child: Transform(
//                   alignment: Alignment.center,
//                   transform: Matrix4.identity()..scale(scale, 1.0),

//                   // transitionOnUserGestures: true,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => NewPage(
//                                     article: articles,
//                                   )));
//                     },
//                     child: Card(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(25),
//                             topRight: Radius.circular(25)),
//                       ),
//                       color: Color(articles.color),
//                       child: SizedBox(
//                           height: itemSize,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                   child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Hero(
//                                     tag: articles.title,
//                                     child: Text(articles.title)),
//                               )),
//                               Hero(
//                                   tag: articles.image,
//                                   child: Lottie.asset(articles.image))
//                             ],
//                           )),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }, childCount: article.length))
//         ],
//       ),
//     );
//   }
// }

// class NewPage extends StatelessWidget {
//   final Article article;
//   const NewPage({Key? key, required this.article}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Hero(tag: article.title, child: Text(article.title)),
//           Hero(
//             // transitionOnUserGestures: true,
//             tag: article.image,
//             child: Container(
//               color: Colors.white,
//               child: Lottie.asset(article.image),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
