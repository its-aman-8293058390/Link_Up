class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? dateOfBirth;
  final String? bio;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.dateOfBirth,
    this.bio,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? '',
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      dateOfBirth: map['dateOfBirth'],
      bio: map['bio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'dateOfBirth': dateOfBirth,
      'bio': bio,
    };
  }
}