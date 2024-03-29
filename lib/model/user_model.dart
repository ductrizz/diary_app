import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


@immutable
class UserModel {
  UserModel({
    this.uid,
    this.isVerified = false,
    this.email,
    this.displayName,
    this.birthday,
    this.diaryEntities,
    this.imageUrl,
    this.gender,
  });

  /*UserModel.fromJson(dynamic json)
      : this(
          uid: json['uid'] as String,
          email: json['email']! as String,
          displayName: json['displayName']! as String,
          birthday: json['birthday']! as String,
          isVerified: json['isVerified']! as bool,
          diaryEntities: json['diaryEntities']! as Map,
          imageUrl: json['imageUrl']! as String,
          //diaryEntities: json['diaryEntities']! as List<DiaryEntity>,

        );*/

  String? uid;
  bool? isVerified;
  final String? email;
  String? displayName;
  String? birthday;
  Map? diaryEntities;
  final String? imageUrl;
  String? gender;
  //List<dynamic>? diaryEntities;

  /*Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'birthday': birthday,
      'email': email,
      'diaryEntities': diaryEntities,
      'imageUrl': imageUrl,
    };
  }*/

  UserModel copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? displayName,
    String? birthday,
    Map? diaryEntities,
    String? imageUrl,
    String? gender,
    //List<DiaryEntity>? diaryEntities
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      birthday: birthday ?? this.birthday,
      isVerified: isVerified ?? this.isVerified,
      diaryEntities: diaryEntities ?? this.diaryEntities,
      imageUrl: imageUrl ?? this.imageUrl,
      gender: gender ?? this.gender,
    );
  }


  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserModel(
      uid: data?['uid'],
      email: data?['email'],
      displayName: data?['displayName'],
      birthday: data?['birthday'],
      diaryEntities: data?['diaryEntities'],
      isVerified: data?['isVerified'],
      imageUrl: data?['imageUrl'],
      gender: data?['gender'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "email": email,
      "displayName": displayName,
      "birthday": birthday,
      "diaryEntities": diaryEntities,
      "imageUrl": imageUrl,
      "gender" : gender
    };
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, isVerified: $isVerified, email: $email, displayName: $displayName, birthday: $birthday, diaryEntities: $diaryEntities, imageUrl : $imageUrl}';
  }
}
