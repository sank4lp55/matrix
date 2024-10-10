import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum EventFilter { upcoming, past }

class EventFilterDialog extends StatefulWidget {
  final EventFilter initialFilter;

  const EventFilterDialog({Key? key, required this.initialFilter}) : super(key: key);

  @override
  _EventFilterDialogState createState() => _EventFilterDialogState();
}

class _EventFilterDialogState extends State<EventFilterDialog> {
  EventFilter? _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Ensure left alignment
          children: [
            // Top part with primary color
            Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/logo_named.svg', // Replace with your logo path
                    height: 15, // Adjust height as needed
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Filter Events',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Content of the dialog
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Left-align the text
                children: [
                  Text(
                    'Select which events you would like to see:',
                    textAlign: TextAlign.left, // Left-align the text
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Radio buttons for filtering
                  RadioListTile<EventFilter>(
                    title: const Text('Upcoming Events'),
                    value: EventFilter.upcoming,
                    groupValue: _selectedFilter,
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero, // Reduced padding
                    onChanged: (EventFilter? value) {
                      setState(() {
                        _selectedFilter = value;
                      });
                    },
                  ),
                  RadioListTile<EventFilter>(
                    title: const Text('Past Events'),
                    value: EventFilter.past,
                    groupValue: _selectedFilter,
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero, // Reduced padding
                    onChanged: (EventFilter? value) {
                      setState(() {
                        _selectedFilter = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Lower part styled similarly to RSVP dialog
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Buttons stay aligned to the right
                  children: [
                    // Cancel Button
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Container(
                        child: const Center(
                          child: Text('Cancel', style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Apply Button
                    InkWell(
                      onTap: () {
                        // Return the selected filter
                        Navigator.of(context).pop(_selectedFilter);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                            child: Text('Apply', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
