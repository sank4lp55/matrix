import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matrix/Widgets/rsvp_dialog.dart';
import 'package:matrix/utils/constants.dart';
import '../Models/event_model.dart';

class EventDetailScreen extends StatelessWidget {
  final Data event;
  final String imageUrl;

  const EventDetailScreen(
      {Key? key, required this.event, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double imageHeight = screenHeight * 0.3;
    double padding = screenWidth * 0.05;
    double titleFontSize = screenWidth * 0.06;
    double bodyFontSize = screenWidth * 0.04;
    double iconSize = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
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
        title: SvgPicture.asset(
          ImageConstants.namedLogo,
          height: 30,
          fit: BoxFit.contain,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: imageHeight,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title ?? 'No Title',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: iconSize, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${event.eventDate} ${event.startTime} ${event.startTimeType} - ${event.endTime} ${event.endTimeType}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: bodyFontSize,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: iconSize, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        event.location ?? 'No Location',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: bodyFontSize,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    event.description ?? 'No Description',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: bodyFontSize,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Venue: ${event.eventVenueName ?? 'N/A'}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: bodyFontSize * 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.eventVenueAddress1 ?? 'N/A',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: bodyFontSize,
                    ),
                  ),
                  Text(
                    event.eventVenueAddress2 ?? 'N/A',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: bodyFontSize,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Total Attendees: ${event.totalAttendee}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: bodyFontSize * 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Scan your QR Code',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: bodyFontSize * 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Image.asset(
                      "assets/qr.png",
                      width: screenWidth * 0.5,
                      height: screenWidth * 0.5,
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
          showDialog(
            context: context,
            builder: (context) => RsvpDialog(),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.event, color: Colors.white),
      ),
    );
  }
}
