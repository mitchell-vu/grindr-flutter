import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool isOnline;
  final String? bio;

  final DateTime lastSeen;
  final DateTime createdAt;

  final bool? showAge;
  final String? age;
  final String? height;
  final String? weight;
  final String? bodyType;
  final bool? showPosition;
  final String? position;
  final String? ethnicity;
  final String? relationshipStatus;
  final List<String>? tags;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.isOnline,
    this.bio,
    required this.lastSeen,
    required this.createdAt,
    this.showAge,
    this.age,
    this.height,
    this.weight,
    this.bodyType,
    this.showPosition,
    this.position,
    this.ethnicity,
    this.relationshipStatus,
    this.tags,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isOnline,
    String? bio,
    DateTime? lastSeen,
    DateTime? createdAt,
    bool? showAge,
    String? age,
    String? height,
    String? weight,
    String? bodyType,
    bool? showPosition,
    String? position,
    String? ethnicity,
    String? relationshipStatus,
    List<String>? tags,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      isOnline: isOnline ?? this.isOnline,
      bio: bio ?? this.bio,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      showAge: showAge ?? this.showAge,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bodyType: bodyType ?? this.bodyType,
      showPosition: showPosition ?? this.showPosition,
      position: position ?? this.position,
      ethnicity: ethnicity ?? this.ethnicity,
      relationshipStatus: relationshipStatus ?? this.relationshipStatus,
      tags: tags ?? this.tags,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      isOnline: map['isOnline'],
      bio: map['bio'],
      lastSeen: (map['lastSeen'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      showAge: map['showAge'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
      bodyType: map['bodyType'],
      showPosition: map['showPosition'],
      position: map['position'],
      ethnicity: map['ethnicity'],
      relationshipStatus: map['relationshipStatus'],
      tags: map['tags'] != null ? List<String>.from(map['tags']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isOnline': isOnline,
      'bio': bio,
      'lastSeen': lastSeen,
      'createdAt': createdAt,
      'showAge': showAge,
      'age': age,
      'height': height,
      'weight': weight,
      'bodyType': bodyType,
      'showPosition': showPosition,
      'position': position,
      'ethnicity': ethnicity,
      'relationshipStatus': relationshipStatus,
      'tags': tags,
    };
  }
}
