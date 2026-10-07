class SingleUserModel {
  final AddressModel address;
  final int id;
  final String email;
  final String username;
  final String password;
  final NameModel name;
  final String phone;
  final int v;

  SingleUserModel({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.v,
  });

  factory SingleUserModel.fromJson(Map<String, dynamic> json) {
    return SingleUserModel(
      address: AddressModel.fromJson(json['address']),

      id: json['id'],

      email: json['email'],

      username: json['username'],

      password: json['password'],

      name: NameModel.fromJson(json['name']),

      phone: json['phone'],

      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),

      'id': id,

      'email': email,

      'username': username,

      'password': password,

      'name': name.toJson(),

      'phone': phone,

      '__v': v,
    };
  }
}

/// ADDRESS MODEL
class AddressModel {
  final GeolocationModel geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  AddressModel({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      geolocation: GeolocationModel.fromJson(json['geolocation']),

      city: json['city'],

      street: json['street'],

      number: json['number'],

      zipcode: json['zipcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geolocation': geolocation.toJson(),

      'city': city,

      'street': street,

      'number': number,

      'zipcode': zipcode,
    };
  }
}

/// GEOLOCATION MODEL
class GeolocationModel {
  final String lat;
  final String long;

  GeolocationModel({required this.lat, required this.long});

  factory GeolocationModel.fromJson(Map<String, dynamic> json) {
    return GeolocationModel(lat: json['lat'], long: json['long']);
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'long': long};
  }
}

/// NAME MODEL
class NameModel {
  final String firstname;
  final String lastname;

  NameModel({required this.firstname, required this.lastname});

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(firstname: json['firstname'], lastname: json['lastname']);
  }

  Map<String, dynamic> toJson() {
    return {'firstname': firstname, 'lastname': lastname};
  }
}
