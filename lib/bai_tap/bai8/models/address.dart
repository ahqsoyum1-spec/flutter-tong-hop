class Address {
  final String address;
  final String city;
  final String state;

  Address({required this.address, required this.city, required this.state});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      city: json['city'],
      state: json['state'],
    );
  }
  
  @override
  String toString() => '$address, $city, $state';
}