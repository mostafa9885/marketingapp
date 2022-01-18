

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketingapp/Moduels/On%20Boarding/on_boarding_screen.dart';
import 'package:marketingapp/Shared/Colors%20and%20Icons/colors_icons.dart';

Widget onBoardingItemBuilder (context,PageViewModel model) => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage(
          '${model.image}',
        ),
      ),
    ),
    const SizedBox(height: 35),
    Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 31,
          color: ColorApp.mainColor,
          fontWeight: FontWeight.bold
        ),
    ),
    const SizedBox(height: 20),
    Text('${model.body}',
      style: TextStyle(
        color: ColorApp.blackColor,
        fontSize: 15,
        fontWeight: FontWeight.w300
      ),
    ),
  ],
);