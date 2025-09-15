// lib/home_page.dart
import 'package:flutter/material.dart';
import 'crop_recommendation_page.dart';
import 'feedback_help_page.dart';
import 'news_page.dart';
import 'weather_page.dart';

const List<Map<String, dynamic>> featureList = [
  {'icon': Icons.show_chart, 'label': 'Crop Market Prices'},
  {'icon': Icons.auto_awesome, 'label': 'AI Assistant'},
  {'icon': Icons.security, 'label': 'Crop Recommendation'},
  {'icon': Icons.bug_report, 'label': 'Pest and Disease Detection'},
  {'icon': Icons.wb_sunny, 'label': 'Weather'},
  {'icon': Icons.phone_android, 'label': 'My Farm Data'},
  {'icon': Icons.currency_rupee, 'label': 'Compare Loans'},
  {'icon': Icons.public, 'label': 'Latest News'},
  {'icon': Icons.feedback, 'label': 'Feedback and Help'},
];

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> features;

  HomePage({Key? key, this.features = featureList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TopBar(),
            SizedBox(height: 16),
            _SearchBar(),
            SizedBox(height: 16),
            _SuggestionArea(),
            SizedBox(height: 18),
            _GridFeatures(featureList: features),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 16, 120, 20),
            const Color.fromARGB(255, 43, 71, 5),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Good morning, User',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      color: const Color.fromARGB(255, 245, 221, 8),
                      size: 22,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '32°C',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 14),
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                child: Icon(Icons.person, color: Colors.black, size: 26),
                radius: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 2, 32, 3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(26),
          color: Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(width: 16),
            Icon(
              Icons.search,
              size: 30,
              color: const Color.fromARGB(221, 0, 0, 0),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),
            Icon(Icons.mic, size: 28, color: Colors.black87),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class _SuggestionArea extends StatefulWidget {
  @override
  _SuggestionAreaState createState() => _SuggestionAreaState();
}

class _SuggestionAreaState extends State<_SuggestionArea> {
  final List<String> imageUrls = [
    'https://picsum.photos/id/1018/200/130',
    'https://picsum.photos/id/1015/200/130',
    'https://picsum.photos/id/1020/200/130',
    'https://picsum.photos/id/1035/200/130',
    'https://picsum.photos/id/1041/200/130',
  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.36);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 5), () {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % imageUrls.length;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(28),
      ),
      child: PageView.builder(
        controller: _pageController,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(imageUrls[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}

class _GridFeatures extends StatelessWidget {
  final List<Map<String, dynamic>> featureList;

  const _GridFeatures({required this.featureList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          itemCount: featureList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 18,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            var feature = featureList[index];
            return FeatureButton(
              icon: feature['icon'],
              label: feature['label'],
              color: Colors.green[100],
              onTap: () {
                // debug log
                print("Tapped: ${feature['label']}");

                final label = (feature['label'] ?? '')
                    .toString()
                    .trim()
                    .toLowerCase();
                if (label == 'crop recommendation') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CropRecommendationPage()),
                  );
                } else if (label == 'feedback and help') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FeedbackHelpPage()),
                  );
                } else if (label == 'latest news') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FarmingNewsPage()),
                  );
                } else if (label == 'weather') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WeatherPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${feature['label']} tapped!')),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const FeatureButton({
    required this.icon,
    required this.label,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.green[100],
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black87),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
