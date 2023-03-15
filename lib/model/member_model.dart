import 'dart:convert';

MemberModel memberModelFromJson(String str) => MemberModel.fromJson(json.decode(str));

String memberModelToJson(MemberModel data) => json.encode(data.toJson());

class MemberModel {
  MemberModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.img,
    required this.diamond,
  });

  int id;
  String firstName;
  String lastName;
  String phone;
  String img;
  int diamond;

  MemberModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? img,
    int? diamond,
  }) =>
      MemberModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        img: img ?? this.img,
        diamond: diamond ?? this.diamond,
      );

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    img: json["img"],
    diamond: json["diamond"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "img": img,
    "diamond": diamond,
  };
}
