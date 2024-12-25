import 'package:flutter/material.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';

class NavigationBarComponent extends StatefulWidget {
  int index = 1;
  NavigationBarComponent({super.key, required this.index});

  @override
  State<NavigationBarComponent> createState() => _NavigationBarComponentState();
}

class _NavigationBarComponentState extends State<NavigationBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: MyColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              if (widget.index == 1)
                const Text(
                  "Dashboard",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )
            ],
          ),
          Row(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.pushNamed(context, '/task');
                },
                icon: const Icon(
                  Icons.assignment_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              if (widget.index == 2)
                const Text(
                  "Tasks",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )
            ],
          ),
          Row(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.pushNamed(context, '/activity');
                },
                icon: const Icon(
                  Icons.list,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              if (widget.index == 3)
                const Text(
                  "Activity",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )
            ],
          ),
          Row(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.pushNamed(context, '/history');
                },
                icon: const Icon(
                  Icons.timeline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              if (widget.index == 4)
                const Text(
                  "history",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )
            ],
          ),
          Row(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              if (widget.index == 5)
                const Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )
            ],
          ),
        ],
      ),
    );
  }
}
