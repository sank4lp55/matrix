import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:matrix/utils/constants.dart';

import '../Blocs/event_bloc.dart';
import '../Widgets/event_card.dart';
import '../Widgets/event_filter_dialog.dart';
import '../Widgets/event_shimmer_card.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  void _openFilterDialog(
      BuildContext context, EventFilter currentFilter) async {
    FocusScope.of(context).unfocus();

    EventFilter? selectedFilter = await showDialog<EventFilter>(
      context: context,
      builder: (BuildContext context) {
        return EventFilterDialog(initialFilter: currentFilter);
      },
    );

    if (selectedFilter != null) {
      context.read<EventBloc>().add(UpdateEventFilter(selectedFilter));
    }
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final screenPadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
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
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05,
                        vertical: screenPadding.top * 0.6,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: screenSize.width * 0.1,
                            height: screenSize.width * 0.1,
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
                            ImageConstants.namedLogo,
                            height: screenSize.height * 0.035,
                            fit: BoxFit.contain,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              print(_searchController.text);
                            },
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
                    SizedBox(height: screenSize.height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.04),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.04),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.search, color: Colors.white),
                                  SizedBox(width: screenSize.width * 0.02),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        context
                                            .read<EventBloc>()
                                            .add(UpdateSearchQuery(value));
                                      },
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
                                  final currentState =
                                      context.read<EventBloc>().state;

                                  if (currentState is EventLoaded) {
                                    final currentFilter =
                                        currentState.eventFilter;
                                    _openFilterDialog(context, currentFilter);
                                  } else {
                                    // Handle the case when the state is not EventLoaded (optional)
                                  }
                                },
                                icon: const Icon(
                                  Icons.filter_list,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.4),
                                ),
                              ),
                              BlocBuilder<EventBloc, EventState>(
                                builder: (context, state) {
                                  if (state is EventLoaded) {
                                    return state.eventFilter != EventFilter.all
                                        ? Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              width: screenSize.width * 0.02,
                                              height: screenSize.width * 0.02,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink();
                                  }
                                  return const SizedBox
                                      .shrink(); // or any other default widget for other states
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    if (state is EventLoading) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.04),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.01),
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
                            .contains(state.searchQuery.toLowerCase());

                        bool matchesFilter;
                        if (state.eventFilter == EventFilter.upcoming) {
                          matchesFilter = isUpcoming;
                        } else if (state.eventFilter == EventFilter.past) {
                          matchesFilter = !isUpcoming;
                        } else {
                          matchesFilter = true;
                        }

                        return matchesSearch && matchesFilter;
                      }).toList();

                      if (events.isEmpty) {
                        return Center(
                          child: Text(
                            'No ${state.eventFilter.toString().substring(state.eventFilter.toString().indexOf('.') + 1)} events available.',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.045,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.04),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.01),
                            child: EventCard(
                              event: events[index],
                              imageIndex: index,
                              id: events[index].id ?? 0,
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
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
