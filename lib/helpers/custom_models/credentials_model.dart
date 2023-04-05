class Credentials {
  late String name;
  late String username;
  late String password;
  late String server;

  Credentials({required this.name, required this.username, required this.password, required this.server});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'server': server,
    };
  }

  static Credentials fromJson(Map<String, dynamic> json) {
    return Credentials(
      name: json['name'],
      username: json['username'],
      password: json['password'],
      server: json['server'],
    );
  }
}