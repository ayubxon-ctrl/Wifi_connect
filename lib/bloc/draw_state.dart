part of 'draw_bloc.dart';

sealed class DrawState {}

final class DrawInitial extends DrawState {}

class DrawSuccesState extends DrawState {}

class DrawFailureState extends DrawState {}
