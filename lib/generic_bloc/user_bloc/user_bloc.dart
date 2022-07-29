import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/diary_entity.dart';
import '../../model/user_model.dart';
import '../../repositories/firebase_storage_repository.dart';
import '../../repositories/firestore_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final FirestoreRepository? _firestoreRepository;
  FirebaseStorageRepository? _firebaseStorageRepository;
  UserBloc({
    FirestoreRepository? firestoreRepository,
    FirebaseStorageRepository? firebaseStorageRepository,
  }): _firebaseStorageRepository = firebaseStorageRepository,
        _firestoreRepository = firestoreRepository, super(UserStateInitial()){
    on<UserEventGetUser>(_getUserModel);
    on<UserEventUpdateInforUser>(_updateInforUser);
    on<UserEventImagePicker>(_handleImagePicking);
   /* on<UserEventSaveInterests>(_handleSaveInterests);*/
  }

  Future<void> _getUserModel(UserEventGetUser event, Emitter<UserState> emit) async{
    emit(UserStateInitial());
    try {
      UserModel? userModel = await _firestoreRepository?.getUserCredentials();
      Map<dynamic, dynamic>? diaryEntitiesPrimary = userModel?.diaryEntities;
      List<DiaryEntity>? diaryEntities = diaryEntitiesPrimary?.values.map((e){
        DiaryEntity? diaryEntity = DiaryEntity.fromJson(e);
        return diaryEntity;
      }).cast<DiaryEntity>().toList();
      diaryEntities?.sort((a, b) => ((a.dateTime ?? "").compareTo(b.dateTime ?? "")));
      List<DiaryEntity>? listDiary = diaryEntities?.reversed.toList();

      emit(UserStateSuccess(userModel: userModel, diaryEntities: listDiary));
    }catch (e){
      print(e);
      emit(UserStateFailure());
    }
  }

  void _updateInforUser(UserEventUpdateInforUser event, Emitter<UserState> emit){
    _firestoreRepository?.updateInfor(userModel: event.userModel);
  }

  FutureOr<void> _handleImagePicking(
      UserEventImagePicker event, Emitter<UserState> emit) async {
    try {
      emit(UserStateImagePickerInProgress());
      final String imagePath = await _firebaseStorageRepository!.pickImageFromGallery();
      if (imagePath.isNotEmpty) {
        File image = File(imagePath);
        //emit(ImagePickerSuccessful(image));
        await _firebaseStorageRepository?.uploadImage(image);
        emit(UserStateImagePickerSuccessful(image));
      } else {
        emit(UserStateImagePickerFailed('No Image Selected'));
      }
    } catch (error) {
      emit(UserStateImagePickerFailed(error.toString()));
    }
  }

}

