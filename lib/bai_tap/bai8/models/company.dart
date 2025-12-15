class Company {
  final String name;
  final String title;
  final String department;

  Company({required this.name, required this.title, required this.department});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      title: json['title'],
      department: json['department'],
    );
  }
}