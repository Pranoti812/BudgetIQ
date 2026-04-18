import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> navIcons = [
      Icons.home_outlined,
      Icons.map_outlined,
      Icons.compare_arrows_outlined,
      Icons.chat_bubble_outline,
      Icons.person_outline,
    ];

    final List<String> navTitles = [
      "Home",
      "Regions",
      "Compare",
      "AI Chat",
      "Profile",
    ];

    return Container(
      height: 82,
      decoration: const BoxDecoration(
        color: Color(0xff162341),
        border: Border(
          top: BorderSide(
            color: Colors.white10,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navIcons.length, (index) {
          final bool isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  navIcons[index],
                  size: 30,
                  color: isSelected
                      ? const Color(0xff00e5b0)
                      : Colors.white54,
                ),
                const SizedBox(height: 5),
                Text(
                  navTitles[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? const Color(0xff00e5b0)
                        : Colors.white54,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}