import 'package:flutter/material.dart';
import 'package:pawrenting/models/pet.dart';
import 'package:pawrenting/components/petCard.dart';

class myPets extends StatefulWidget {
  const myPets({super.key});

  @override
  State<myPets> createState() => _myPetsState();
}

class _myPetsState extends State<myPets> {
  List<Pet> petList = [];
  List<String> textList = [
    'anjay1',
    'anjay2',
    'anjay3',
    'anjay4',
    'anjay5'
  ];

  void getPetList(){
    petList = Pet.getPetList();
  }
  @override


  Widget build(BuildContext context) {
    getPetList();
    return Scaffold(
      backgroundColor: Color(0xffC5BEDB),
      appBar: appBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 75,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              'MY PETS',
              style: TextStyle(
                fontFamily: 'Albert Sans',
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
            sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index){
                return petCard(
                  name: petList[index].name,
                  gender: petList[index].gender,
                  age: petList[index].age,
                  dob: petList[index].dob,
                  weight: petList[index].weight,
                  height: petList[index].height,
                  );
              },
                childCount: petList.length
              ), 
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: double.infinity,
                mainAxisExtent: 200,
                mainAxisSpacing: 20,
              )
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.red,
              width: 100,
              height: 100,
            )
          )
        ],
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