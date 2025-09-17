import 'package:flutter/foundation.dart';

class DiseaseLog {
  final String diseaseName;
  final DateTime date;
  final String notes;

  DiseaseLog({required this.diseaseName, required this.date, this.notes = ''});
}

class FarmPlot {
  String farmName;
  double area; // e.g., in acres or hectares
  String crop;
  String soilType;
  String? location;
  DateTime sowingDate;
  int? irrigationInterval; // in days
  int? pluckingInterval; // in days, for vegetables
  List<DiseaseLog> diseaseHistory;
  String? notes;

  FarmPlot({
    required this.farmName,
    required this.area,
    required this.crop,
    required this.soilType,
    required this.sowingDate,
    this.location,
    this.irrigationInterval,
    this.pluckingInterval,
    this.notes,
    List<DiseaseLog>? diseaseHistory,
  }) : this.diseaseHistory = diseaseHistory ?? [];
}
