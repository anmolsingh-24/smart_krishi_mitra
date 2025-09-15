// lib/news_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmingNewsPage extends StatelessWidget {
  final List<Map<String, String>> newsArticles = [
    {
      "title": "Natural farming boosts commercial crop yield in Solan, HP",
      "summary":
          "A case study shows natural farming significantly enhances commercial crops like capsicum. [12 Sep 2025]",
      "source": "Down To Earth",
      "url":
          "https://krishijagran.com/news/rabi-conference-2025-two-day-national-agriculture-conference-begins-in-delhi-today",
    },
    {
      "title": "Odisha’s ‘Dongar’ cultivation in danger",
      "summary":
          "Traditional hill farming in Odisha faces threat due to climate and market changes. [01 Sep 2025]",
      "source": "Down To Earth",
      "url":
          "https://www.downtoearth.org.in/agriculture/odishas-dongar-cultivation-in-danger",
    },
    {
      "title": "Crop residue burning impacts soil microbes",
      "summary":
          "Research shows burning crop residue disrupts soil biodiversity and increases pests. [22 Aug 2025]",
      "source": "Down To Earth",
      "url":
          "https://www.downtoearth.org.in/agriculture/crop-residue-burning-has-impacts-beyond-pollution-study-finds-disruption-in-microbial-biodiversity",
    },
    {
      "title": "Kenya turns to India for rice imports",
      "summary":
          "Unsold harvests in India prompt rice exports to Kenya amidst changing global demand. [18 Aug 2025]",
      "source": "Down To Earth",
      "url":
          "https://www.downtoearth.org.in/agriculture/kenya-turns-to-india-for-rice-imports-as-farmers-decry-unsold-harvests-89369",
    },
    {
      "title": "Women farmers in Karnataka win global UN award",
      "summary":
          "A women farmers' group from Karnataka among winners of the UNDP Equator Prize 2025. [13 Aug 2025]",
      "source": "Down To Earth",
      "url":
          "https://www.downtoearth.org.in/agriculture/karnataka-women-farmers-group-among-global-winners-of-undp-equator-prize-2025-88701",
    },
  ];

  FarmingNewsPage({Key? key}) : super(key: key);

  Future<void> _openExternal(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farming News',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF228B22),
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFFF3FFF3),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: newsArticles.length,
          itemBuilder: (context, index) {
            final article = newsArticles[index];
            return GestureDetector(
              onTap: () {
                final rawUrl = article['url'] ?? '';
                if (rawUrl.isNotEmpty) {
                  _openExternal(context, rawUrl);
                }
              },
              child: Card(
                color: Colors.white,
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article["title"] ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF228B22),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        article["summary"] ?? "",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.public,
                            color: Colors.green[700],
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            article["source"] ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
