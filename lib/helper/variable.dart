import 'package:flutter/material.dart';

double mainWidth = 0.0;
double mainHight = 0.0;

double paddingAll = 0.040;

void init(BuildContext context) {
  mainWidth = MediaQuery.of(context).size.width;
  mainHight = MediaQuery.of(context).size.height;
}
