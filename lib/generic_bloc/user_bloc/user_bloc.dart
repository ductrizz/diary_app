import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../model/diary_entity.dart';
import '../../model/user_model.dart';
import '../../repositories/firestore_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final FirestoreRepository? _firestoreRepository;
  UserBloc({FirestoreRepository? firestoreRepository}):
        _firestoreRepository = firestoreRepository, super(UserStateInitial()){
    on<UserEventGetUser>(_getUserModel);
    on<UserEventUpdateInforUser>(_updateInforUser);
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

  }


}