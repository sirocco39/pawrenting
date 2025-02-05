import 'package:flutter/material.dart';
import 'package:pawrentingreborn/utils/constants/colors.dart';
import 'package:pawrentingreborn/utils/constants/images_strings.dart';
import 'package:pawrentingreborn/utils/constants/texts.dart';

class Profilepictandusername extends StatelessWidget {
  const Profilepictandusername({super.key, this.profilePicture, required this.name, required this.username});
  final String username; 
  final String name;
  final String? profilePicture;

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Stack(
          children: [
            // background profile pic 
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.fromLTRB(0, 45, 0, 10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: TColors.gray,
              ),
            ),
            // profile pic
            Positioned(
              top: 30, 
              right: 1,
              left: 1,
              child: Image.asset(
                profilePicture != null? this.profilePicture! : TImages.profilePicDefault,
                width: 150,
                height: 150,
              ),
            ),
          ],
        ),
        // Name 
        Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Albert Sans',
              fontWeight: FontWeight.bold
            )
          ),
        ),
        //user name
        Center(
          child: Text(
            username,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Albert Sans',
              fontWeight: FontWeight.bold, 
              color: TColors.grayFont
            )
          ),
        ),

      ],
    );
  }

}