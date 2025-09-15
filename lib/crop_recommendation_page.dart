// lib/crop_recommendation_page.dart
import 'package:flutter/material.dart';

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
        title: Text("Crop Recommendation"),
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
                  SizedBox(height: 8),
                  Text(
                    "This will help you predict the best suited crop for you based on your soil and weather condition",
                    style: TextStyle(color: Colors.black87),
                  ),
                  SizedBox(height: 20),

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

                  SizedBox(height: 30),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // prototype-only action
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Form Submitted"),
                            content: Text(
                              "Prototype only — no backend connected.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
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
