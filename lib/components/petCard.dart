import 'package:flutter/material.dart';

class petCard extends StatelessWidget {
  final String name;
  final String gender;
  final int age;
  final String dob;
  final int weight;
  final int height;

  petCard({
    required this.name,
    required this.gender,
    required this.age,
    required this.dob,
    required this.weight,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image(image: AssetImage('assets/icons/ktp.png')),
          Positioned(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 68, 15, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 82.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey,
                    ),
                    child: Image.asset('assets/icons/whiskey.png'),
                  ),
                  Container(
                    // color: Colors.green,
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    width: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            height: 0.75
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DoB',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              dob,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 0.75
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              gender,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 0.75
                              ),
                            )
                          ],
                        ),
                      ]
                    ),
                  ),
                  Container(
                    // color: Colors.green,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    width: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Age',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              age.toString() + ' y.o',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 0.75
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Height',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              height.toString() + ' cm',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 0.75
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weight',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              weight.toString() + ' kg',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 0.75
                              ),
                            )
                          ],
                        ),
                      ]
                    ),
                  ),
                ],
              )
            ),
          )
        ]
      ),
    );
  }
}