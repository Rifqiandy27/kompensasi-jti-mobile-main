class User {
  final String name;
  final String username;
  final String telp;
  final String alamat;
  final String image;
  final int semester;
  final String prodi;

  User({
    required this.name,
    required this.username,
    required this.telp,
    required this.alamat,
    required this.image,
    required this.semester,
    required this.prodi,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],
      telp: json['telp'],
      alamat: json['alamat'],
      image: json['image'],
      semester: json['semester'],
      prodi: json['prodi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'telp': telp,
      'alamat': alamat,
      'image': image,
      'semester': semester,
      'prodi': prodi,
    };
  }
}
