// lib/crop_recommendation_page.dart
import 'package:flutter/material.dart';
import 'crop_recommendation_page_output.dart';

class CropRecommendationPage extends StatelessWidget {
  final TextEditingController soilController = TextEditingController();
  final TextEditingController nController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController kController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phController = TextEditingController();

  CropRecommendationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop Recommendation"),
        backgroundColor: Colors.green.shade800,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Crop Recommendation",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "This will help you predict the best suited crop for you based on your soil and weather condition",
                    style: TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 20),

                  // Input fields (blank by default)
                  _buildTextField("Enter your Soil Type", soilController),
                  _buildTextField(
                    "Enter the percentage of Nitrogen (N)",
                    nController,
                  ),
                  _buildTextField(
                    "Enter the percentage of Phosphorus (P)",
                    pController,
                  ),
                  _buildTextField(
                    "Enter the percentage of Potassium (K)",
                    kController,
                  ),
                  _buildTextField("Your location", locationController),
                  _buildTextField("pH level", phController),

                  const SizedBox(height: 30),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to output page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const CropRecommendationPageOutput(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.green.shade800),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.green.shade800, width: 2),
          ),
        ),
      ),
    );
  }
}
