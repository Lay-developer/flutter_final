import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reading/helper/variable.dart';

class MyAppBar extends StatelessWidget {
  final VoidCallback onTap;
  const MyAppBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        image: DecorationImage(
            image: AssetImage(
              'assets/images/bg1.png',
            ),
            fit: BoxFit.fill),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 8, spreadRadius: -5)],
                      color: Colors.grey,
                      shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        onTap();
                      },
                      icon: const ImageIcon(
                        AssetImage(
                          'assets/images/favourite.png',
                        ),
                      )),
                )
              ],
            ),
          ),
          Row(
            children: [
              Text.rich(
                TextSpan(
                  text: 'What are you\nreading today?',
                  style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontSize: 23,
                  ),
                ),
                textAlign: TextAlign.start,
              ),
            ],
          )
        ],
      ),
    );
  }
}
