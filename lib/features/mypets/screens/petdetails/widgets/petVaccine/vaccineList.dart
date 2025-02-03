// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pawrentingreborn/utils/constants/colors.dart';
import 'package:pawrentingreborn/utils/constants/images_strings.dart';

class VaccineList extends StatelessWidget {
  const VaccineList({super.key, this.date, required this.name, required this.taken});

  final String name;
  final String? date;
  final bool taken;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 350,
      decoration: BoxDecoration(
        color: TColors.gray,
        border: Border.all(
          color: TColors.accent
        ),
        borderRadius: BorderRadius.circular(10)        
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    height: 1,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                taken
                ?
                Text(
                  'Taken on: ' + date!,
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff797272)
                  ),
                )
                :
                Text(
                  'Not taken yet...',
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff797272)
                  ),
                )
                ,
                taken
                ?
                Image(image: AssetImage(TImages.taken), height: 20,)
                :
                Image(image: AssetImage(TImages.nottaken), height: 20,)
              ],
            ),
            ImageIcon(
              AssetImage(TImages.arrowForwardIcon),
              size: 14,
              )
          ],
        )
        ),
    );
  
  }
}