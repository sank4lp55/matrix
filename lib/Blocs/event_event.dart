part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEvents extends EventEvent {}

class UpdateEventFilter extends EventEvent {
  final EventFilter filter;

  UpdateEventFilter(this.filter);
}

class UpdateSearchQuery extends EventEvent {
  final String query;

  UpdateSearchQuery(this.query);
}
