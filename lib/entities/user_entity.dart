class UserEntity {
  String username;
  String email;

  UserEntity({required this.username, required this.email});

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(username: map['username'], email: map['email']);
  }

  toMap() {
    return {'username': username, 'email': email};
  }
}
