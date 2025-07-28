class Login {
  String? idLogin;
  String? name;
  String? session_id;

  Login({
    this.name,
    this.idLogin,
    this.session_id,
});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      idLogin: json['id_login'] ?? '-',
      name: json['nama'] ?? '-',
      session_id: json['session_id'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'id_login': idLogin,
      'nama': name,
      'session_id': session_id,
    };
  }
}