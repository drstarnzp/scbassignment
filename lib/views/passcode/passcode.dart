import 'dart:async';

import 'package:flutter/material.dart';

import '../../assets/app_colors.dart';
import '../../feature/home/home.dart';

class PasscodeLockScreen extends StatefulWidget {
  final Function() onDismissDialog;

  const PasscodeLockScreen({super.key, required this.onDismissDialog});

  @override
  _PasscodeLockScreenState createState() => _PasscodeLockScreenState();
}

class _PasscodeLockScreenState extends State<PasscodeLockScreen> {
  final List<String> items = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "",
    "0",
    "",
  ];

  String passcode = "123456"; // Current passcode for testing
  String enteredPasscode = "";

  void _clearEnteredPasscode() {
    setState(() {
      enteredPasscode = "";
    });
  }

  void _onDigitPressed(String digit) {
    setState(() {
      enteredPasscode += digit;
    });

    if (enteredPasscode.length == 6) {
      if (enteredPasscode == passcode) {
        Navigator.of(context).pop();
        widget.onDismissDialog();
      } else {
        _clearEnteredPasscode();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dimDarkPurple,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'This is just sample UI.\nOpen to create your style :D',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildDot(enteredPasscode.length >= 1),
                buildDot(enteredPasscode.length >= 2),
                buildDot(enteredPasscode.length >= 3),
                buildDot(enteredPasscode.length >= 4),
                buildDot(enteredPasscode.length >= 5),
                buildDot(enteredPasscode.length >= 6),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: items.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (BuildContext context, int index) {
                  final digit = (index + 1).toString();

                  return GridItem(
                    pinText: items[index],
                    onDigitPressed: _onDigitPressed,
                    digit: digit,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(bool filled) {
    return Container(
      width: 20,
      height: 20,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? Colors.black : Colors.grey,
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String pinText;
  final String digit;
  final Function(String) onDigitPressed;

  const GridItem(
      {super.key,
      required this.pinText,
      required this.onDigitPressed,
      required this.digit});

  @override
  Widget build(BuildContext context) {
    if (pinText.isNotEmpty) {
      return Container(
          child: FloatingActionButton(
        onPressed: () => {onDigitPressed(digit)},
        shape: const CircleBorder(),
        backgroundColor: AppColors.lightGrey,
        child: Text(
          pinText,
          style: TextStyle(fontSize: 24),
        ),
      ));
    } else {
      return Container();
    }
  }
}