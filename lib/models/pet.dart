import 'package:flutter/material.dart';

class Pet {
  String name;
  int age;
  String gender;

  Pet({
    required this.name,
    required this.age,
    required this.gender,
  });

  static List<Pet> getPetList(){
    List<Pet> petList = [];
    petList.add(
      Pet(
        name: 'Whiskey',
        age: 3,
        gender: 'Female',
        )
    );
    return petList;
  }
}