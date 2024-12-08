import 'package:flutter/material.dart';

class Pet {
  String name;
  int age;
  String gender;
  String dob;
  int weight;
  int height;

  Pet({
    required this.name,
    required this.age,
    required this.gender,
    required this.dob,
    required this.height,
    required this.weight,
  });

  static List<Pet> getPetList(){
    List<Pet> petList = [];
    petList.add(
      Pet(
        name: 'Whiskey',
        age: 3,
        gender: 'Female',
        dob: '22-06-2021',
        height: 20,
        weight: 3,
        )
    );
    petList.add(
      Pet(
        name: 'Puppy',
        age: 5,
        gender: 'Male',
        dob: '16-06-2019',
        height: 22,
        weight: 4,
        )
    );
        petList.add(
      Pet(
        name: 'Monyet',
        age: 2,
        gender: 'Male',
        dob: '11-11-2022',
        height: 30,
        weight: 5,
        )
    );
    return petList;
  }
}