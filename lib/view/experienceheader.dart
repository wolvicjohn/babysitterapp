import 'package:flutter/cupertino.dart';

class ExperienceHeader extends StatelessWidget {
  ExperienceHeader({super.key});

  final List userExperience = [
    'Experience 1',
    'Experience 2',
    'Experience 3',
    'Experience 4',
    'Experience 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Experience',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Column(
            children: userExperience.map((experience) {
              return Row(
                children: [
                  const Icon(CupertinoIcons.checkmark_alt),
                  const SizedBox(width: 5),
                  Text(experience),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
