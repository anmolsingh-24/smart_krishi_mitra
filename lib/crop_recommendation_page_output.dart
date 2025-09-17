// lib/crop_recommendation_page_output.dart
import 'package:flutter/material.dart';

class CropRecommendationPageOutput extends StatelessWidget {
  const CropRecommendationPageOutput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop Recommendation Output"),
        backgroundColor: Colors.green.shade800,
      ),
      body: const Center(
        child: Text(
          "The output is here — this works fine!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
