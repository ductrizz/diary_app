import 'package:diary_app/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/diary_entity.dart';
import 'firestore_repository.dart';

class UserRepository extends Equatable{
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  FirestoreRepository? _fireStoreRepository;

  UserRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

//Sign-In method
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signIn({required String email, required String password,}) async{
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

//SignUp method
  Future<void> signUp({required String email, required String password, required displayName}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    var user = await _firebaseAuth.currentUser;

    UserModel userModel = UserModel(
        uid: user?.uid,
        email: user?.email,
        displayName: displayName,
        isVerified: user?.emailVerified,
        diaryEntities: Map(),
    );
    _fireStoreRepository = FirestoreRepository();
    _fireStoreRepository?.saveUserCredentials(userModel: userModel);
    print('user uid:: ${user?.uid}');
    //return userModel;
  }
//SignOut
  Future<void> signOut() async {
      return Future(() => Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]));

  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  User? getUser() {
    return _firebaseAuth.currentUser;
  }

//Password change and reset
  Future<void> passwordChange(String password, String newPassword) async {
    try {
      await _firebaseAuth.currentUser?.updatePassword(newPassword);
    } on PlatformException catch (error) {
      throw Exception(error);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (error) {
      throw Exception(error);
    }
  }

//Verify email
  Future<void> sendVerificationEmail() async {
    try {
      final user = await _firebaseAuth.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {

    }
  }

  Future<bool> isEmailExisted({required String email}) async{
    var listEmail = await _firebaseAuth.fetchSignInMethodsForEmail(email);
    return listEmail.isNotEmpty;
  }



  @override
  List<Object?> get props => [];

}

