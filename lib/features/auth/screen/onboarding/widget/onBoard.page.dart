import 'package:flutter/material.dart';

class OnBoardPage extends StatelessWidget {
  final String image, title, subtitle;
  const OnBoardPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Spacer(),
          Image.asset(height: 250, width: 250, image),
          Spacer(),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            subtitle,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
