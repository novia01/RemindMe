class User {
  String id_pasien;
  String nomorRM;
  String namaPasien;
  String email;
  String password;

  User(
    this.id_pasien,
    this.nomorRM,
    this.namaPasien,
    this.email,
    this.password,
  );
  
  factory User.fromJson(Map<String, dynamic> json) => User (
    json["id_pasien"],
    json["nomorRM"],
    json["namaPasien"],
    json["email"],
    json["password"],
  );

  Map<String, dynamic> toJson() => {
    'id_pasien' : id_pasien,
    'nomorRM' : nomorRM,
    'namaPasien' : namaPasien,
    'email' : email,
    'password' : password,
  };
}