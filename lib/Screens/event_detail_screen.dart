import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matrix/Widgets/rsvp_dialog.dart';
import '../Models/event_model.dart';

class EventDetailScreen extends StatelessWidget {
  final Data event;
  final String imageUrl;

  const EventDetailScreen(
      {Key? key, required this.event, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/logo_named.svg',
              height: 30, // Adjust height as needed
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8), // Add some space between logo and title
            Expanded(
              child: Text(
                event.title ?? 'Event Details',
                textAlign: TextAlign.center, // Center the title text
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            Image.network(
              imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Title
                  Text(
                    event.title ?? 'No Title',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Event Date and Time
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${event.eventDate} ${event.startTime} ${event.startTimeType} - ${event.endTime} ${event.endTimeType}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Event Location
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        event.location ?? 'No Location',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Event Description
                  Text(
                    event.description ?? 'No Description',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),

                  // Venue Information
                  Text(
                    'Venue: ${event.eventVenueName ?? 'N/A'}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(event.eventVenueAddress1 ?? 'N/A',
                      style: TextStyle(color: Colors.grey[700])),
                  Text(event.eventVenueAddress2 ?? 'N/A',
                      style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(height: 16),

                  // Attendee Information
                  Text(
                    'Total Attendees: ${event.totalAttendee}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  // QR Code Placeholder
                  Center(
                    child: Text(
                      'Scan your QR Code',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                      child: Image.asset(
                    "assets/qr.png",
                    width: 200,
                    height: 200,
                  )),
                  SizedBox(height: 8),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle RSVP action here
          showDialog(
            context: context,
            builder: (context) => RsvpDialog()
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.event, color: Colors.white),
      ),
    );
  }
}
