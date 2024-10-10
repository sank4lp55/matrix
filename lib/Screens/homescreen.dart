import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../Blocs/event_bloc.dart';
import '../Widgets/event_card.dart';
import '../Widgets/event_filter_dialog.dart';
import '../Widgets/event_shimmer_card.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';
  EventFilter _eventFilter = EventFilter.all;

  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(LoadEvents());
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  void _openFilterDialog(BuildContext context) async {
    _searchFocusNode.unfocus();
    EventFilter? selectedFilter = await showDialog<EventFilter>(
      context: context,
      builder: (BuildContext context) {
        return EventFilterDialog(initialFilter: _eventFilter);
      },
    );
    if (selectedFilter != null) {
      setState(() {
        _eventFilter = selectedFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
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
                            height: 30,
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
                                      focusNode: _searchFocusNode,
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
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ShimmerEventCard(),
                          );
                        },
                      );
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

                        bool matchesFilter;
                        if (_eventFilter == EventFilter.upcoming) {
                          matchesFilter = isUpcoming;
                        } else if (_eventFilter == EventFilter.past) {
                          matchesFilter = !isUpcoming;
                        } else {
                          matchesFilter = true;
                        }

                        return matchesSearch && matchesFilter;
                      }).toList();

                      if (events.isEmpty) {
                        return Center(
                          child: Text(
                            'No ${_eventFilter.toString().substring(_eventFilter.toString().indexOf('.') + 1)} events available.',
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
                            child: EventCard(
                              event: events[index],
                              imageIndex: index,
                              id: events[index].id ?? 0,
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox.shrink();
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
