import 'package:flutter/material.dart';
import 'package:travsy/src/utils/colors.dart';

class IndexViewWidget extends StatelessWidget {
  int selectedIndex;
  IndexViewWidget({
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          selectedIndex.toString(),
          style: TextStyle(
            color: zPrimaryColor,
            fontSize: 14,
          ),
        ),
        Text(
          "/8",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
