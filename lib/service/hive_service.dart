import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/person_model.dart';

class HiveDB {
  static var box = Hive.box('spiskaUz');
  static var boxBonus = Hive.box('boolValue');

  /// to save currency
  static void storeCurrency([String currency = 'So\'m']) async {
    box.put('currency', currency);
  }

  static String loadCurrency() {
    String currency = box.get('currency');
    return currency;
  }

  static void removeCurrency() {
    box.delete('currency');
  }

  /// to save Is get bonus?
  static void storeIsGet({bool isGetBonus = false}) async {
    boxBonus.put('isGetBonus', isGetBonus);
  }

  static bool loadIsGet() {
    bool isGetBonus = boxBonus.get('isGetBonus');
    return isGetBonus;
  }

  static void removeIsGet() {
    boxBonus.delete('isGetBonus');
  }

  /// to save timer
  static void storeTimer(DateTime time) async {
    box.put('time', time);
  }

  static DateTime loadTimer() {
    DateTime time = box.get('time');
    return time;
  }

  static void removeTimer() {
    box.delete('time');
  }

  /// store user info

  static void storePerson(Person person) async {
    await box.put('person', person.toJson());
  }

  static Person loadPerson() {
    Person person =
        Person.fromJson(Map<String, dynamic>.from(box.get('person')));
    return person;
  }

  static void removePerson() {
    debugPrint('remove person fnk');
    box.delete('person');
  }
}
