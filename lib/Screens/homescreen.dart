import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../Blocs/event_bloc.dart';
import '../Widgets/event_card.dart';
import '../Widgets/event_filter_dialog.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode(); // FocusNode to manage the TextField focus
  String _searchQuery = '';
  EventFilter _eventFilter = EventFilter.all; // Default filter

  @override
  void initState() {
    super.initState();

    // Load events when the screen initializes
    context.read<EventBloc>().add(LoadEvents());

    // Add a listener to the search controller to detect search query changes
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    // Clean up the controller and focus node when the widget is disposed
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose(); // Dispose of the FocusNode
    super.dispose();
  }

  // Method to handle changes in the search query
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  void _openFilterDialog(BuildContext context) async {
    // Unfocus the TextField before opening the dialog
    _searchFocusNode.unfocus();

    // Open the dialog and wait for the result
    EventFilter? selectedFilter = await showDialog<EventFilter>(
      context: context,
      builder: (BuildContext context) {
        return EventFilterDialog(
          initialFilter: _eventFilter,
        );
      },
    );

    // If a filter is selected (i.e., not canceled), take action
    if (selectedFilter != null) {
      setState(() {
        _eventFilter = selectedFilter; // Update the filter state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Unfocus the TextField when tapping outside
          _searchFocusNode.unfocus();
        },
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                color: theme.primaryColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.primaryColor,
                              border: Border.all(color: Colors.white),
                            ),
                            child: const Icon(
                              Icons.home_outlined,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/icons/logo_named.svg',
                            height: 30, // Adjust height as needed
                            fit: BoxFit.contain,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.4)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.search, color: Colors.white),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      focusNode: _searchFocusNode, // Attach FocusNode
                                      style: const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _openFilterDialog(context);
                                },
                                icon: const Icon(
                                  Icons.filter_list,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Colors.white.withOpacity(0.4)),
                              ),
                              _eventFilter != EventFilter.all
                                  ? Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                                  : const SizedBox.shrink(),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    if (state is EventLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is EventError) {
                      return Center(child: Text(state.message));
                    } else if (state is EventLoaded) {
                      final currentDate = DateTime.now();
                      final events = state.events.where((event) {
                        final eventDate =
                        DateFormat('yyyy-MM-dd').parse(event.eventDate!);
                        final isUpcoming = eventDate.isAfter(currentDate);
                        bool matchesSearch = event.title!
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase());

                        // Filter based on the search query and selected filter
                        bool matchesFilter;
                        if (_eventFilter == EventFilter.upcoming) {
                          matchesFilter = isUpcoming;
                        } else if (_eventFilter == EventFilter.past) {
                          matchesFilter = !isUpcoming;
                        } else {
                          matchesFilter = true; // Include all events
                        }

                        return matchesSearch && matchesFilter;
                      }).toList();

                      // Check if the events list is empty
                      if (events.isEmpty) {
                        return Center(
                          child: Text(
                            'No events available.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: EventCard(event: events[index],imageIndex: index,),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
