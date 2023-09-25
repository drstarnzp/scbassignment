import 'package:flutter/material.dart';
import 'package:scbassignment/views/home.dart';
import 'package:scbassignment/views/passcode.dart';

void main() => runApp(const ScbAssignment());

class ScbAssignment extends StatelessWidget {
  const ScbAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
