import 'package:flutter/material.dart';

import '../Models/event_model.dart';

class EventCard extends StatelessWidget {
  final Data event; // Change type to Data

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(event.title ?? 'No Title'),
        subtitle: Text(event.eventDate ?? 'No Date'),
        onTap: () {},
      ),
    );
  }
}
