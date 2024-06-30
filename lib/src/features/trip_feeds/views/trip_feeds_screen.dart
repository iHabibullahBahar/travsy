import 'package:flutter/material.dart';
import 'package:travsy/src/features/trip_feeds/widgets/feed_trip_widget.dart';
import 'package:travsy/src/utils/colors.dart';
import 'package:travsy/src/utils/dimensions.dart';

class TripFeedsScreen extends StatelessWidget {
  const TripFeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: zBackgroundColor,
            title: const Text(
              "Trip Feeds",
              style: TextStyle(
                color: zTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            elevation: 0,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.zDefaultPadding,
        ),
        child: ListView(
          children: [
            for (int i = 0; i < 10; i++) FeedTripWidget(),
          ],
        ),
      ),
    );
  }
}
