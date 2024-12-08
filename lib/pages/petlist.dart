import 'package:flutter/material.dart';
import 'package:pawrenting/models/pet.dart';

class myPets extends StatefulWidget {
  const myPets({super.key});

  @override
  State<myPets> createState() => _myPetsState();
}

class _myPetsState extends State<myPets> {
  @override

  List<Pet> petList = [];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC5BEDB),
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
      floatingActionButton: translateButton(),
      bottomNavigationBar: navBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 60,
      leadingWidth: 190,
      leading: Container(
        // color: Colors.amber,
        margin: EdgeInsets.all(15),
        child: FittedBox(
          child: Image.asset('assets/icons/pawrentingLogo.png'),
        ),
      ),
      actions: [
        Container(
          // color: Colors.amber,
          width: 77.5,
          margin: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageIcon(AssetImage('assets/icons/shoppingcart.png'), color: Color(0xff707DAB), size: 30,),
              ImageIcon(AssetImage('assets/icons/notif.png'), color: Color(0xff707DAB), size: 30,)
            ]
          ),
        )
      ],
    );
  }

  SizedBox translateButton() {
    return SizedBox(
      width: 110,
      height: 110,
      child: FittedBox(
        child: FloatingActionButton.large(
          onPressed: null,
          shape: CircleBorder(),
          backgroundColor: Color(0xff4749AE),
          child: Image.asset('assets/icons/translate.png', height: 55,)
          ),
      ),
    );
  }

  BottomAppBar navBar() {
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