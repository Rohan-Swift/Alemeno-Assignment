import 'package:alemeno_task/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'GOOD JOB',
              style: GoogleFonts.lilitaOne(
                fontSize: 48,
                color: const Color(0xFF3E8B3A),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
                (route) => false, // This will remove all previous routes
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange, // Set the background color to orange
            ),
            child: const Text(
              'Go Home',
            ),
          ),
        ],
      ),
    );
  }
}
