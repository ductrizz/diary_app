import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


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

//Set, Get, Remove data by normal method

  Future<void> writeDiary({required DiaryEntity? newDiary})async{
// Atomically add a new region to the "regions" array field.
    _docRefGet?.update({
      "diaryEntities": FieldValue.arrayUnion([newDiary?.toJson()]),
    });
  }

  Future<void> modifyDiary({required DiaryEntity? oldDiary, required DiaryEntity? newDiary})async{
// Atomically add a new region to the "regions" array field.
   var Start = _docRefGet;
   await _docRefGet?.update({
      "diaryEntities" : FieldValue.arrayRemove([oldDiary?.toJson()]),
    });
   await _docRefGet?.update({
      "diaryEntities": FieldValue.arrayUnion([newDiary?.toJson()]),
    });
  }

  Future<void> deleteDiary({required DiaryEntity diaryEntity})async{
    _docRefGet?.update({
      "diaryEntities" : FieldValue.arrayRemove([diaryEntity.toJson()]),
    });
  }
}