import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'save_data_event.dart';
part 'save_data_state.dart';

class SaveDataBloc extends Bloc<SaveDataEvent, SaveDataState> {
  SaveDataBloc() : super(SaveDataInitial()) {
    on<SaveDataFetchEvent>(saveDataFetchEvent);
    on<SaveDataSaveEvent>(saveDataSaveEvent);
  }

  FutureOr<void> saveDataFetchEvent(
      SaveDataFetchEvent event, Emitter<SaveDataState> emit) {}

  FutureOr<void> saveDataSaveEvent(
      SaveDataSaveEvent event, Emitter<SaveDataState> emit) {}
}
