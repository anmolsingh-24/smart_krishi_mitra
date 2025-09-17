import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/farm_plot.dart';

class AddFarmPlotPage extends StatefulWidget {
  const AddFarmPlotPage({Key? key}) : super(key: key);

  @override
  _AddFarmPlotPageState createState() => _AddFarmPlotPageState();
}

class _AddFarmPlotPageState extends State<AddFarmPlotPage> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers and variables
  final _farmNameController = TextEditingController();
  final _areaController = TextEditingController();
  final _cropController = TextEditingController();
  final _soilTypeController = TextEditingController();
  final _irrigationIntervalController = TextEditingController();
  final _pluckingIntervalController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime? _sowingDate;

  @override
  void dispose() {
    _farmNameController.dispose();
    _areaController.dispose();
    _cropController.dispose();
    _soilTypeController.dispose();
    _irrigationIntervalController.dispose();
    _pluckingIntervalController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectSowingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _sowingDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Apply theme to DatePicker
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green, // Header background
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
            ), // Selected day color
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _sowingDate) {
      setState(() {
        _sowingDate = picked;
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      if (_sowingDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a sowing date.'),
            backgroundColor: Colors.red, // Indicating an error
          ),
        );
        return;
      }

      final newPlot = FarmPlot(
        farmName: _farmNameController.text,
        area: double.parse(_areaController.text),
        crop: _cropController.text,
        soilType: _soilTypeController.text,
        sowingDate: _sowingDate!,
        irrigationInterval: _irrigationIntervalController.text.isNotEmpty
            ? int.parse(_irrigationIntervalController.text)
            : null,
        pluckingInterval: _pluckingIntervalController.text.isNotEmpty
            ? int.parse(_pluckingIntervalController.text)
            : null,
        notes: _notesController.text,
      );

      // Return the new plot to the previous screen
      Navigator.of(context).pop(newPlot);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define a green theme for input fields
    final greenInputDecoration = InputDecoration(
      labelStyle: const TextStyle(color: Colors.green), // Label text color
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green.shade300, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 12.0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Farm Plot'),
        backgroundColor: Colors.green, // AppBar background
        foregroundColor: Colors.white, // AppBar icon and text color
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _farmNameController,
                  decoration: greenInputDecoration.copyWith(
                    labelText: 'Farm/Field Name',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _areaController,
                  decoration: greenInputDecoration.copyWith(
                    labelText: 'Area (e.g., in acres)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter an area' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cropController,
                  decoration: greenInputDecoration.copyWith(
                    labelText: 'Crop (e.g., Rice, Tomato)',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a crop type' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _soilTypeController,
                  decoration: greenInputDecoration.copyWith(
                    labelText: 'Soil Type',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a soil type' : null,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _sowingDate == null
                            ? 'No Sowing Date Chosen'
                            : 'Sowing Date: ${DateFormat.yMd().format(_sowingDate!)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ), // Sowing date text color
                      ),
                    ),
                    TextButton(
                      onPressed: () => _selectSowingDate(context),
                      style: TextButton.styleFrom(
                        foregroundColor:
                            Colors.green, // "Choose Date" text color
                      ),
                      child: const Text('Choose Date'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _irrigationIntervalController,
                  decoration: greenInputDecoration.copyWith(
                    labelText: 'Irrigation Interval (days)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _pluckingIntervalController,
                  decoration: greenInputDecoration.copyWith(
                    labelText: 'Plucking/Harvest Interval (days)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  decoration: greenInputDecoration.copyWith(labelText: 'Notes'),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Button background color
                      foregroundColor: Colors.white, // Button text color
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Save Farm Plot',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
