# Matrix

A Flutter event management application designed to provide users with an interactive experience for discovering and managing events.

## Features

- **User-friendly Interface**: Intuitive navigation and layout for seamless user experience.
- **Event Filtering**: Users can filter events based on different criteria (upcoming, past).
- **Search Functionality**: Users can search for events quickly using the search bar.
- **Dynamic Event Cards**: Events are displayed in a visually appealing card format.
- **Responsive Design**: Optimized for different screen sizes.

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/sank4lp55/matrix.git
   ```

2. Navigate to the project directory:
   ```bash
   cd matrix
   ```

3. Install the dependencies:
   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
│
├── Blocs/          # Bloc files for state management
│   ├── event_bloc.dart
│   ├── event_event.dart
│   └── event_state.dart
│
├── Models/         # Data models
│   └── event_model.dart
│
├── Repositories/   # Data fetching and API interaction
│   └── event_repository.dart
│
├── Screens/        # Screen widgets
│   ├── event_detail_screen.dart
│   ├── homescreen.dart
│   ├── onboarding.dart
│   └── splash_screen.dart
│
├── Widgets/        # Custom widgets
│   ├── event_card.dart
│   ├── event_filter_dialog.dart
│   ├── event_shimmer_card.dart
│   ├── matrix_button.dart
│   └── rsvp_dialog.dart
│
├── utils/          # Utility files
│   └── constants.dart
│
└── main.dart       # Entry point of the application
```

## Screens

1. **Splash Screen** (`splash_screen.dart`):
   - Displays the app logo with a fade-in animation.
   - Automatically navigates to the Onboarding screen after a short delay.

2. **Onboarding** (`onboarding.dart`):
   - Introduces users to the app's main features.
   - Provides a "Get Started" button to navigate to the Home screen.

3. **Home Screen** (`homescreen.dart`):
   - Displays a list of events.
   - Includes search functionality and event filtering options.
   - Shows event cards with basic information.

4. **Event Detail Screen** (`event_detail_screen.dart`):
   - Provides detailed information about a specific event.
   - Displays event image, title, date, time, location, and description.
   - Includes a QR code for event check-in.
   - Offers an RSVP option via a floating action button.

## Data Flow

The app follows a clean architecture pattern:

1. **Repository** (`event_repository.dart`):
   - Responsible for fetching event data from the API.
   - Uses the `http` package to make network requests.
   - Parses the JSON response into `EventModel` objects.

2. **Bloc** (`event_bloc.dart`, `event_event.dart`, `event_state.dart`):
   - Manages the state of the events in the app.
   - Responds to user actions (like loading events or applying filters).
   - Uses the `EventRepository` to fetch data when needed.

3. **UI** (Screens and Widgets):
   - Displays data from the Bloc.
   - Sends user actions back to the Bloc.

This structure ensures a separation of concerns, making the code more maintainable and testable.

## Usage

* The app starts with a Splash Screen, followed by an Onboarding page.
* On the Home Screen, browse through the list of events or use the search bar to find specific events.
* Tap the filter icon to apply filters to the event list (e.g., upcoming or past events).
* Click on an event card to view more details about the event on the Event Detail Screen.
* Use the RSVP button on the Event Detail Screen to respond to event invitations.

## Contributing

Contributions are welcome! If you have suggestions for improvements or features, please create an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments

* Special thanks to the Flutter community for the incredible resources and support.
