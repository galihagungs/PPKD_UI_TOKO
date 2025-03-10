import 'package:flutter/material.dart';

class Dummyhomepage extends StatelessWidget {
  const Dummyhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text("API"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/homeSQL');
              },
              child: Text("SQL"),
            ),
          ],
        ),
      ),
    );
  }
}
