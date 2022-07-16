import 'package:diary_app/pages/read_diary/read_diary_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../model/diary_entity.dart';
import '../../../repositories/firestore_repository.dart';


part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState>{
  FirestoreRepository _firestoreRepository;

  DiaryBloc({
    required FirestoreRepository firestoreRepository}) :
        _firestoreRepository = firestoreRepository,
        super(DiaryStateInitial()){
    on<DiaryEventRead>(_onReadDiary);
    on<DiaryEventWrite>(_onWriteDiary);
    on<DiaryEventModify>(_onModifyDiary);
    on<DiaryEventDelete>(_onDeleteDiary);
  }



  Future<void> _onReadDiary(DiaryEventRead event, Emitter<DiaryState> emit) async{
    emit(DiaryStateReadInitial());
    try{
      emit(DiaryStateReadSuccess(diaryEntity : event.diaryEntity));
    }on Exception catch (e){
      emit(DiaryStateReadFailure(messageError: e.toString()));
    }
  }

  Future<void> _onWriteDiary(DiaryEventWrite event, Emitter<DiaryState> emit) async{
    emit(DiaryStateWriteInitial());
    try{
      _firestoreRepository.writeDiary(
          newDiary: event.newDiary);
      emit(DiaryStateWriteSuccess());
    }on Exception catch (e){
      emit(DiaryStateWriteFailure(messageError: e.toString()));
    }
  }

  Future<void> _onModifyDiary(DiaryEventModify event, Emitter<DiaryState> emit) async{
    emit(DiaryStateModifyInitial());
    try{
      await _firestoreRepository.modifyDiaryTest(index: event.index, newDiary: event.newDiary);
      emit(DiaryStateModifySuccess());
    }on Exception catch (_){
      emit(DiaryStateModifyFailure());
    }
  }

  Future<void> _onDeleteDiary(DiaryEventDelete event, Emitter<DiaryState> emit) async{
    emit(DiaryStateDeleteInitial());
    try{
      _firestoreRepository.deleteDiary(
          diaryEntity: event.diaryEntity!);
      emit(DiaryStateDeleteSuccess());
    }on Exception catch (_){
      emit(DiaryStateDeleteFailure());
    }
  }


}