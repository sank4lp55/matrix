import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/event_bloc.dart';
import '../Widgets/event_card.dart';
import '../Widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(LoadEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Management')),
      body: Column(
        children: [
          SearchField(controller: _searchController, onChanged: (String value) {  },),
          Expanded(
            child: BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                if (state is EventLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is EventError) {
                  return Center(child: Text(state.message));
                } else if (state is EventLoaded) {
                  final events = state.events.where((event) {
                    return event.title!.toLowerCase().contains(_searchController.text.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return EventCard(event: events[index]);
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
