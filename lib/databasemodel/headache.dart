final String tableinfo = 'userinfo';

class userinfoFields{
  static final String id = 'id';
  static final String username = 'username';
  static final String password = 'password';
  static final String gender = 'gender';
}

class userinfo {
  final int? id;
  final String username;
  final String password;
  final bool gender;

  const userinfo({
    this.id,
    required this.username,
    required this.password,
    required this.gender,
  });
}