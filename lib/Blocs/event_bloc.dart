import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../Models/event_model.dart';
import '../Repositories/event_repopsitory.dart';

// Bloc events
part 'event_event.dart';

// Bloc states
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;

  EventBloc(this.eventRepository) : super(EventInitial()) {
    on<LoadEvents>((event, emit) async {
      emit(EventLoading());
      try {
        final events = await eventRepository.fetchEvents();
        emit(EventLoaded(events));
      } catch (e) {
        emit(EventError('Failed to load events: $e'));
      }
    });
  }
}
