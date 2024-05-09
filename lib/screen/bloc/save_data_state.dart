part of 'save_data_bloc.dart';

@immutable
sealed class SaveDataState {}

final class SaveDataInitial extends SaveDataState {}

final class SaveLoading extends SaveDataState {}

final class SaveLoaded extends SaveDataState {}
