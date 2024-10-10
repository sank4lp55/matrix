part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEvents extends EventEvent {}
