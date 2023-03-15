import 'package:equatable/equatable.dart';

class Person extends Equatable {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? img;
  int? diamond;

  Person({this.id, this.firstName, this.lastName, this.phone, this.img});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    img = json['img'];
    diamond = json['diamond'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['img'] = img;
    data['diamond'] = diamond;
    return data;
  }

  @override
  List<Object?> get props => [id, firstName, lastName, phone];
}
