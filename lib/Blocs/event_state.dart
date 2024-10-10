part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Data> events;
  final EventFilter eventFilter; // Added this property
  final String searchQuery; // This holds the current search query

  EventLoaded(this.events, this.eventFilter, this.searchQuery); // Updated constructor

  @override
  List<Object?> get props => [events, eventFilter, searchQuery]; // Include in props
}

class EventError extends EventState {
  final String message;

  EventError(this.message);

  @override
  List<Object?> get props => [message];
}
