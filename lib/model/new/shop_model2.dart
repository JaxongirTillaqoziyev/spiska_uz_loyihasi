import '../person_model.dart';

class ShopModel2 {
  int? status;
  List<CreatorAdmin>? creatorAdmin;
  List<dynamic>? user;

  ShopModel2({this.status, this.creatorAdmin, this.user});

  ShopModel2.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['creator-admin'] != null) {
      creatorAdmin = <CreatorAdmin>[];
      json['creator-admin'].forEach((v) {
        creatorAdmin!.add(CreatorAdmin.fromJson(v));
      });
    }
    if (json['user'] != null) {
      user = [];
      json['user'].forEach((v) {
        user!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (creatorAdmin != null) {
      data['creator-admin'] = creatorAdmin!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatorAdmin {
  Host? host;
  List<Person>? admins;
  List<Person>? members;
  List<Person>? asistants;
  List<dynamic>? promocodes;
  List<dynamic>? selected;
  List<dynamic>? output;
  List<dynamic>? input;
  List<dynamic>? moneyHistory;
  int? id;
  String? type;
  String? name;
  String? description;
  String? currency;
  int? dollarCurrency;
  String? img;
  String? viloyat;
  String? tuman;
  Location? location;
  List? products;

  CreatorAdmin(
      {this.host,
      this.admins,
      this.members,
      this.asistants,
      this.promocodes,
      this.selected,
      this.output,
      this.input,
      this.moneyHistory,
      this.id,
      this.type,
      this.name,
      this.description,
      this.currency,
      this.dollarCurrency,
      this.img,
      this.viloyat,
      this.tuman,
      this.location,
      this.products});

  CreatorAdmin.fromJson(Map<String, dynamic> json) {
    host = json['host'] != null ? Host.fromJson(json['host']) : null;
    if (json['admins'] != null) {
      admins = <Person>[];
      json['admins'].forEach((v) {
        admins!.add(Person.fromJson(v));
      });
    }
    if (json['members'] != null) {
      members = <Person>[];
      json['members'].forEach((v) {
        members!.add(Person.fromJson(v));
      });
    }
    if (json['asistants'] != null) {
      asistants = <Person>[];
      json['asistants'].forEach((v) {
        asistants!.add(Person.fromJson(v));
      });
    }
    if (json['promocodes'] != null) {
      promocodes = <Null>[];
      json['promocodes'].forEach((v) {
        promocodes!.add(Person.fromJson(v));
      });
    }
    if (json['selected'] != null) {
      selected = <Null>[];
      json['selected'].forEach((v) {
        selected!.add(Person.fromJson(v));
      });
    }
    if (json['output'] != null) {
      output = <Null>[];
      json['output'].forEach((v) {
        output!.add(Person.fromJson(v));
      });
    }
    if (json['input'] != null) {
      input = <Null>[];
      json['input'].forEach((v) {
        input!.add(Person.fromJson(v));
      });
    }
    if (json['money-history'] != null) {
      moneyHistory = <Null>[];
      json['money-history'].forEach((v) {
        moneyHistory!.add(Person.fromJson(v));
      });
    }
    id = json['id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    currency = json['currency'];
    dollarCurrency = json['dollar_currency'];
    img = json['img'];
    viloyat = json['viloyat'];
    tuman = json['tuman'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    if (json['products'] != null) {
      products = <Null>[];
      json['products'].forEach((v) {
        products!.add(Person.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (host != null) {
      data['host'] = host!.toJson();
    }
    if (admins != null) {
      data['admins'] = admins!.map((v) => v.toJson()).toList();
    }
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    if (asistants != null) {
      data['asistants'] = asistants!.map((v) => v.toJson()).toList();
    }
    if (promocodes != null) {
      data['promocodes'] = promocodes!.map((v) => v.toJson()).toList();
    }
    if (selected != null) {
      data['selected'] = selected!.map((v) => v.toJson()).toList();
    }
    if (output != null) {
      data['output'] = output!.map((v) => v.toJson()).toList();
    }
    if (input != null) {
      data['input'] = input!.map((v) => v.toJson()).toList();
    }
    if (moneyHistory != null) {
      data['money-history'] = moneyHistory!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['description'] = description;
    data['currency'] = currency;
    data['dollar_currency'] = dollarCurrency;
    data['img'] = img;
    data['viloyat'] = viloyat;
    data['tuman'] = tuman;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Host {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? img;
  int? diamond;

  Host(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.img,
      this.diamond});

  Host.fromJson(Map<String, dynamic> json) {
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
}

class Location {
  String? lat;
  String? lon;

  Location({this.lat, this.lon});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}
