class User {
  final String id;
  String name;
  String email;
  String password;
  String dateOfBirth;
  String country;
  String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.country,
    this.profileImage,
  });

  User copyWith({
    String? name,
    String? email,
    String? password,
    String? dateOfBirth,
    String? country,
    String? profileImage,
  }) {
    return User(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      country: country ?? this.country,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

// Sample user data
List<User> sampleUsers = [
  User(
    id: '1',
    name: 'Melissa Peters',
    email: 'melpeters@gmail.com',
    password: '••••••••',
    dateOfBirth: '23/08/1990',
    country: 'Nigeria',
    profileImage: 'https://randomuser.me/api/portraits/women/44.jpg',
  ),
  User(
    id: '2',
    name: 'John Smith',
    email: 'johnsmith@gmail.com',
    password: '••••••••',
    dateOfBirth: '15/04/1985',
    country: 'United States',
    profileImage: 'https://randomuser.me/api/portraits/men/32.jpg',
  ),
  User(
    id: '3',
    name: 'Sarah Johnson',
    email: 'sarahj@gmail.com',
    password: '••••••••',
    dateOfBirth: '10/12/1992',
    country: 'Canada',
    profileImage: 'https://randomuser.me/api/portraits/women/68.jpg',
  ),
];
