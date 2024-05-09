part of 'save_data_bloc.dart';

@immutable
abstract class SaveDataEvent {}

final class SaveDataFetchEvent extends SaveDataEvent {}

final class SaveDataSaveEvent extends SaveDataEvent {}
