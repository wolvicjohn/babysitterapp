import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutHeader extends StatefulWidget {
  final String userFirstName;
  final String userAbout;

  const AboutHeader({
    super.key,
    required this.userFirstName,
    required this.userAbout,
  });

  @override
  State<AboutHeader> createState() => _AboutHeaderState();
}

class _AboutHeaderState extends State<AboutHeader> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About ${widget.userFirstName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.userAbout,
              textAlign: TextAlign.justify,
              maxLines: isExpanded ? null : 5,
              overflow:
                  isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: (isExpanded)
                      ? const Icon(CupertinoIcons.chevron_up)
                      : const Icon(CupertinoIcons.chevron_down),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
