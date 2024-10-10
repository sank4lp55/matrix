import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/event_model.dart';

class EventRepository {
  static const String apiUrl = 'https://dummyjson.com/c/ce86-3a2c-4f87-9bd2';

  Future<List<Data>> fetchEvents() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      EventModel eventModel = EventModel.fromJson(jsonResponse);
      return eventModel.data ?? [];
    } else {
      throw Exception('Failed to load events');
    }
  }
}
