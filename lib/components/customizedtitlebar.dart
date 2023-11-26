import 'package:flutter/material.dart';

class CustomizedTitleBar extends StatelessWidget {
  const CustomizedTitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Notes",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          //by default it has padding so we remove it
          padding: const EdgeInsets.all(0),
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade800.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.sort,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
