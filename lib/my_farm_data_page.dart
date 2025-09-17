import 'package:flutter/material.dart';
import '../models/farm_plot.dart';
import 'add_farm_plot_page.dart';
import 'package:intl/intl.dart';

class MyFarmDataPage extends StatefulWidget {
  const MyFarmDataPage({Key? key}) : super(key: key);

  @override
  _MyFarmDataPageState createState() => _MyFarmDataPageState();
}

class _MyFarmDataPageState extends State<MyFarmDataPage> {
  // In a real app, this data would come from a database (Firebase, SQLite, etc.)
  final List<FarmPlot> _farmPlots = [
    // Dummy data for demonstration
    FarmPlot(
      farmName: "North Field",
      area: 5.0,
      crop: "Rice",
      soilType: "Alluvial",
      sowingDate: DateTime(2025, 6, 15),
      irrigationInterval: 7,
    ),
    FarmPlot(
      farmName: "Kitchen Garden",
      area: 0.5,
      crop: "Tomato",
      soilType: "Loamy",
      sowingDate: DateTime(2025, 8, 1),
      irrigationInterval: 3,
      pluckingInterval: 5,
    ),
  ];

  void _navigateToAddPlotPage() async {
    // Navigate and wait for a result
    final newPlot = await Navigator.of(context).push<FarmPlot>(
      MaterialPageRoute(builder: (context) => const AddFarmPlotPage()),
    );

    // If a new plot was created and returned, add it to the list
    if (newPlot != null) {
      setState(() {
        _farmPlots.add(newPlot);
      });
      // Here you would also schedule notifications
      _scheduleNotifications(newPlot);
    }
  }

  void _scheduleNotifications(FarmPlot plot) {
    // This is where you would integrate with a notification service
    // like flutter_local_notifications.

    if (plot.irrigationInterval != null) {
      print(
        'SCHEDULING: Irrigation reminder for ${plot.farmName} (${plot.crop}) every ${plot.irrigationInterval} days.',
      );
      // Example logic:
      // localNotificationsPlugin.periodicallyShow(
      //   plot.hashCode, // unique ID
      //   'Irrigation Reminder',
      //   'Time to irrigate your ${plot.crop} at ${plot.farmName}.',
      //   RepeatInterval.everyMinute, // For testing. Use RepeatInterval.daily for real app and manage logic
      //   notificationDetails,
      // );
    }

    if (plot.pluckingInterval != null) {
      print(
        'SCHEDULING: Plucking reminder for ${plot.farmName} (${plot.crop}) every ${plot.pluckingInterval} days.',
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Farm plot saved and reminders scheduled!'),
        backgroundColor: Colors.green, // Green for success
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Farm Data'),
        backgroundColor: Colors.green, // AppBar background
        foregroundColor: Colors.white, // AppBar icon and text color
      ),
      body: _farmPlots.isEmpty
          ? const Center(
              child: Text(
                'No farm plots added yet.\nTap the "+" button to get started!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _farmPlots.length,
              itemBuilder: (context, index) {
                final plot = _farmPlots[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Colors.green.shade100, // Light green background
                      foregroundColor:
                          Colors.green.shade800, // Darker green text
                      child: Text(plot.crop.substring(0, 1)),
                    ),
                    title: Text(
                      plot.farmName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ), // Farm name in green
                    subtitle: Text(
                      '${plot.crop} - ${plot.area} acres',
                      style: const TextStyle(color: Colors.grey),
                    ), // Subtitle can remain subtle
                    trailing: Text(
                      'Sown:\n${DateFormat.yMd().format(plot.sowingDate)}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.green,
                      ), // Sowing date in green
                    ),
                    onTap: () {
                      // TODO: Navigate to a detail page to view/edit plot and add diseases
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPlotPage,
        backgroundColor: Colors.green, // Plus button background
        foregroundColor: Colors.white, // Plus icon color
        child: const Icon(Icons.add),
        tooltip: 'Add New Farm Plot',
      ),
    );
  }
}
