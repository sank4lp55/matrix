import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum EventFilter { all, upcoming, past }

class EventFilterDialog extends StatefulWidget {
  final EventFilter initialFilter;

  const EventFilterDialog({Key? key, required this.initialFilter})
      : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/logo_named.svg',
                    height: 15,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select which events you would like to see:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Radio buttons for filtering
                  RadioListTile<EventFilter>(
                    title: const Text('All Events'),
                    value: EventFilter.all,
                    groupValue: _selectedFilter,
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (EventFilter? value) {
                      setState(() {
                        _selectedFilter = value;
                      });
                    },
                  ),
                  RadioListTile<EventFilter>(
                    title: const Text('Upcoming Events'),
                    value: EventFilter.upcoming,
                    groupValue: _selectedFilter,
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero,
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
                    contentPadding: EdgeInsets.zero,
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

            // Divided container
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left part with one color
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Container(
                        color: Colors.lightGreen.shade50,
                        // Change this color as needed
                        alignment: Alignment.center,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  // Right part with another color
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.of(context)
                            .pop(_selectedFilter); // Return the selected filter
                      },
                      child: Container(
                        color: Theme.of(context)
                            .primaryColor, // Change this color as needed
                        alignment: Alignment.center,
                        child: const Text(
                          'Apply',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
