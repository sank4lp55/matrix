import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../Models/event_model.dart';
import '../Repositories/event_repopsitory.dart';
import '../Widgets/event_filter_dialog.dart';

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
        emit(EventLoaded(events, EventFilter.all, '')); // Pass initial values
      } catch (e) {
        emit(EventError('Failed to load events: $e'));
      }
    });

    on<UpdateEventFilter>((event, emit) {
      if (state is EventLoaded) {
        final currentState = state as EventLoaded;
        emit(EventLoaded(currentState.events, event.filter, currentState.searchQuery));
      }
    });

    on<UpdateSearchQuery>((event, emit) {
      if (state is EventLoaded) {
        final currentState = state as EventLoaded;
        emit(EventLoaded(currentState.events, currentState.eventFilter, event.query));
      }
    });
  }
}

