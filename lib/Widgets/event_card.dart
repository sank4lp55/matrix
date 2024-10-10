import 'package:flutter/material.dart';
import 'package:matrix/utils/constants.dart';
import '../Models/event_model.dart';
import '../Screens/event_detail_screen.dart';

class EventCard extends StatelessWidget {
  final Data event;
  final int imageIndex;

  const EventCard({Key? key, required this.event,required this.imageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Construct the image URL dynamically
    String imageUrl = '';
    if (imageIndex >= 0 && imageIndex < ImageConstants.images.length) {
      imageUrl = '${ImageConstants.baseUrl}${ImageConstants.images[imageIndex]}';
    } else {
      // Provide a default image URL if the index is out of bounds
      imageUrl = '${ImageConstants.baseUrl}${ImageConstants.images[0]}'; // Fallback to the first image
    }
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(event: event,imageUrl: imageUrl,),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(12),
        elevation: 8, // Adds shadow for elevation effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // Ensures the image fits within rounded corners
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image
              Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0), // Padding for content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title ?? 'No Title',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          event.eventDate ?? 'No Date',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          event.location ?? 'No Location',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
