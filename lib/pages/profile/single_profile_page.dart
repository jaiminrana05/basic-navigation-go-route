import 'package:flutter/material.dart';

class SingleProfilePage extends StatelessWidget {
  const SingleProfilePage({
    Key? key,
    required this.profileId,
  }) : super(key: key);

  final int profileId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Profile'),
      ),
      body: Center(
        child: Text(
          'Profile :$profileId',
        ),
      ),
    );
  }
}
