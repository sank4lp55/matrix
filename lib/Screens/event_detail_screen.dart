import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Models/event_model.dart';

class EventDetailScreen extends StatelessWidget {
  final Data event;

  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title ?? 'Event Details'),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            Image.network(
              'https://dummyjson.com/image/200x100/282828',
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
                  const SizedBox(height: 8),

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
            builder: (context) => Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                // Rounded corners for the entire dialog
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top part with primary color
                    Container(
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/logo_named.svg',
                            // Replace with your logo path
                            height: 15, // Adjust height as needed
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            'RSVP',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Would you like to RSVP for this event?',
                          style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'By RSVPing, you will receive updates about the event.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Lower part styled
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        // Light background for the lower part
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),


                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,0,8,0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Container(
                                    child: Center(
                                      child: const Text('Cancel',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: () {
                                    // Implement RSVP logic here
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'You have successfully RSVP\'d!'),
                                      ),
                                    );
                                  },
                                  child: Container(

                                    decoration: BoxDecoration(  color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                                        child: const Text('RSVP',
                                            style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.event, color: Colors.white),
      ),
    );
  }
}
