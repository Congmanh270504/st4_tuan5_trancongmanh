class Account {
  int? id;
  final String email;
  final String password;

  Account({this.id, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {"id": id, 'email': email, 'password': password};
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      email: map['email'],
      password: map['password'],
    );
  }
  @override
  String toString() {
    return 'Account{id: $id, email: $email, password: $password}';
  }
}

List<Account> accountList = [
  Account(email: "manh@gmail.com", password: "123"),
  Account(email: "aaa@gmail.com", password: "431"),
];
