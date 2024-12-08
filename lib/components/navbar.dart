import 'package:flutter/material.dart';

class navBar extends StatelessWidget {
  const navBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(AssetImage('assets/icons/homeicon.png'),
                    size: 40,
                    color: Color(0xff707DAB),),
                  Text('Home',
                  style: TextStyle(fontSize: 10, color: Color(0xff707DAB)),),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(AssetImage('assets/icons/mypet.png'),
                    size: 38,
                    color: Color(0xff707DAB),),
                  Text('My Pets',
                  style: TextStyle(fontSize: 10, color: Color(0xff707DAB)))
                ],
              ),
            ),
            SizedBox(
              width: 80,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(AssetImage('assets/icons/communityicon.png'),
                    size: 38,
                    color: Color(0xff707DAB),),
                  Text('Community',
                  style: TextStyle(fontSize: 10, color: Color(0xff707DAB)),),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(AssetImage('assets/icons/profile2.png'),
                    size: 40,
                    color: Color(0xff707DAB),),
                  Text('Profile',
                  style: TextStyle(fontSize: 10, color: Color(0xff707DAB)),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}