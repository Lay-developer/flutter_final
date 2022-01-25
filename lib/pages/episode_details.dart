import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reading/models/character.dart';
import 'package:reading/models/episode.dart';

class EpisodeDetails extends StatelessWidget {
  final Episode episode;
  // final Character character;
  const EpisodeDetails({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: 0.2,
              child: Container(
                width: size.width,
                height: size.height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  image: DecorationImage(
                      image: NetworkImage(episode.image), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
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
              top: size.width * 0.80,
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: Text(
                  episode.episodeTitle,
                  style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Positioned(
              top: size.width * 0.90,
              child: Container(
                  width: size.width,
                  height: size.height,
                  padding: EdgeInsets.all(size.width * 0.038),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              episode.description,
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  wordSpacing: 0.8),
                            )),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
