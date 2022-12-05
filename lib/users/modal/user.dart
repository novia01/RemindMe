class User {
  String nomorRM;
  String namaPasien;
  String email;
  String password;

  User(
    this.nomorRM,
    this.namaPasien,
    this.email,
    this.password,
  );
  
  factory User.fromJson(Map<String, dynamic> json) => User (
    json["nomorRM"],
    json["namaPasien"],
    json["email"],
    json["password"],
  );

  Map<String, dynamic> toJson() => {
    'nomorRM' : nomorRM,
    'namaPasien' : namaPasien,
    'email' : email,
    'password' : password,
  };
}