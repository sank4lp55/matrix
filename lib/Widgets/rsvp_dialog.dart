import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RsvpDialog extends StatelessWidget {
  const RsvpDialog({Key? key}) : super(key: key);

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
                  const SizedBox(width: 3),
                  const Text(
                    'RSVP',
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
            // Left-aligned text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Would you like to RSVP for this event?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Left-aligned text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '* By RSVPing, you will receive updates about the event.',
                  style: TextStyle(
                      color: Colors.black, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const SizedBox(height: 15),

            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0), // Uniform padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left part with Cancel button
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Container(
                          color: Colors.lightGreen.shade50,
                          alignment: Alignment.center,
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    // Right part with RSVP button
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('You have successfully RSVP\'d!'),
                            ),
                          );
                        },
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.center,
                          child: const Text(
                            'RSVP',
                            style: TextStyle(color: Colors.white),
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
