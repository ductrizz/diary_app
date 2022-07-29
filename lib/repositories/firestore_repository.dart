import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';


import '../model/diary_entity.dart';
import '../model/user_model.dart';

class FirestoreRepository {
  final FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DocumentReference? _docRefGet;

//used Custom objects for Set, Get, Remove data
  Future<DocumentReference> docRef()async{
    String? uid = await FirebaseAuth.instance.currentUser?.uid.toString();
    print('getDocument uid : $uid');
    var docRef = FirebaseFirestore.instance.collection('Users').doc(uid)
        .withConverter(
      fromFirestore: UserModel.fromFirestore,
      toFirestore: (UserModel userModel, options) => userModel.toFirestore(),
    );
    return docRef;
  }

  Future<void> saveUserCredentials({required UserModel userModel}) async {
    _docRefGet = await docRef();
    await _docRefGet?.set(userModel);
  }

  Future<UserModel> getUserCredentials() async {
    _docRefGet = await docRef();
    DocumentSnapshot? docSnap = await _docRefGet?.get();
    if(docSnap?.exists ?? false){
      final userModel = docSnap?.data() as UserModel;
      return userModel;
    }else{
      return UserModel();
    }
  }

  Future<void> updateInfor({required UserModel? userModel}) async {
    _docRefGet = await docRef();
    await _docRefGet?.update({
      "displayName" : userModel?.displayName ?? "",
      "birthday" : userModel?.birthday ?? "" ,

    });
  }

  Future<void> writeDiary({required String? date, required DiaryEntity? newDiary})async {
    _docRefGet?.update({
        "diaryEntities.${date}": newDiary?.toJson(),
    });
  }


  Future<void> deleteDiaryTest({required String date})async{
    _docRefGet?.update({
      "diaryEntities.${date}": FieldValue.delete(),
    });
  }

}