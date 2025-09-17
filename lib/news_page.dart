// lib/news_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmingNewsPage extends StatelessWidget {
  final List<Map<String, String>> newsArticles = [
    {
      "title":
          "Kharif Sowing Crosses 1,110 Lakh Hectares; Rice, Maize Rise, Oilseeds Decline",
      "summary":
          "India’s Kharif sowing has crossed 1,110 lakh hectares this season, led by strong gains in rice and maize acreage. However, oilseeds and some pulses have seen a decline. [17 Sep 2025]",
      "source": "Krishi Jagaran",
      "url":
          "https://krishijagran.com/news/kharif-sowing-crosses-1-110-lakh-hectares-rice-maize-rise-oilseeds-decline/",
    },

    {
      "title":
          "National Conference on Agriculture- Rabi Campaign 2025 Concludes in New Delhi with Key Policy Resolutions",
      "summary":
          "Union Agriculture Minister Shivraj Singh Chouhan concluded the two-day National Conference on Agriculture focusing on strengthening agricultural strategies for the upcoming Rabi season. Key resolutions include curbing counterfeit agricultural inputs and expanding PMFBY coverage. [16 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/news/national-conference-on-agriculture-rabi-campaign-2025-concludes-in-new-delhi-with-key-policy-resolutions/",
    },

    // News Instance 2
    {
      "title":
          "India's Agriculture Grows at World's Fastest 3.7% Rate: Shivraj Singh Appreciates Farmers at Rabi Abhiyan 2025",
      "summary":
          "Speaking at the Rabi Conference 2025-26, Union Agriculture Minister highlighted India's agricultural growth rate of 3.7%, fastest in the world. The conference emphasized boosting farmers' income and promoting sustainable farming systems for national food security. [15 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/news/indias-agriculture-grows-at-world-s-fastest-37-rate-shivraj-singh-appreciates-farmers-scientists-and-government-policies-at-rabi-abhiyan-2025-conference/",
    },

    // News Instance 3
    {
      "title":
          "PM Modi Inaugurates Rs 10-Crore Sex Sorted Semen Facility in Bihar to Boost Dairy Sector",
      "summary":
          "Prime Minister Narendra Modi inaugurated a state-of-the-art sex sorted semen facility worth Rs 10 crore in Bihar. This advanced technology will help dairy farmers increase milk production and improve cattle breeding efficiency across the region. [16 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/news/pm-modi-inaugurates-rs-10-crore-sex-sorted-semen-facility-in-bihar-to-boost-dairy-sector/",
    },

    // News Instance 4
    {
      "title":
          "Fresh Low-Pressure Systems Likely to Bring Heavy Rainfall to Telangana, Odisha, Assam and Uttarakhand",
      "summary":
          "India Meteorological Department (IMD) warns of fresh low-pressure systems developing over Bay of Bengal that could trigger heavy to very heavy rainfall across multiple states. Farmers advised to take precautionary measures for standing crops. [17 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/news/fresh-low-pressure-systems-likely-to-bring-heavy-rainfall-to-telangana-odisha-assam-and-uttarakhand/",
    },

    // News Instance 5
    {
      "title":
          "ICAR-NBFGR Develops Designer Clownfish through Selective Hybridization, Promoting Ornamental Fish Farming",
      "summary":
          "Indian Council of Agricultural Research's National Bureau of Fish Genetic Resources has successfully developed designer clownfish varieties through selective hybridization. This breakthrough is expected to boost India's ornamental fish farming sector significantly. [16 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/news/icar-nbfgr-develops-designer-clownfish-through-selective-hybridization-promoting-ornamental-fish-farming/",
    },

    // News Instance 6
    {
      "title":
          "Bioethanol Plant Inaugurated in Assam, PM Modi Says Bamboo Farmers to Benefit from Rs 200 Crore Investment",
      "summary":
          "Prime Minister Modi inaugurated a new bioethanol plant in Assam that will process bamboo and other agricultural residues. The Rs 200 crore annual investment is expected to provide sustainable income opportunities for bamboo farmers across Northeast India. [17 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/news/bioethanol-plant-inaugurated-in-assam-pm-modi-says-bamboo-farmers-to-benefit-from-rs-200-crore-annual-investment/",
    },

    // News Instance 7
    {
      "title":
          "Monsoon Withdrawal Begins, IMD Warns of Heavy Rain in Northeast, Maharashtra and Bihar",
      "summary":
          "The India Meteorological Department announced the beginning of monsoon withdrawal from northwestern parts of the country. However, heavy rainfall is expected to continue in Northeast states, Maharashtra, and Bihar over the next few days. [16 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/news/monsoon-withdrawal-begins-imd-warns-of-heavy-rain-in-northeast-maharashtra-and-bihar/",
    },

    // News Instance 8
    {
      "title":
          "FAO Welcomes WTO Fisheries Subsidies Agreement to Curb Illegal Fishing, Promote Sustainability",
      "summary":
          "The Food and Agriculture Organization has welcomed the World Trade Organization's fisheries subsidies agreement aimed at curbing illegal, unreported and unregulated fishing. The agreement is expected to promote sustainable fishing practices globally. [16 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/news/fao-welcomes-wto-fisheries-subsidies-agreement-to-curb-illegal-fishing-promote-sustainability/",
    },

    // News Instance 9
    {
      "title":
          "10th Asian PGPR Society India Chapter National Conference Concludes in Jammu",
      "summary":
          "The 10th Asian Plant Growth Promoting Rhizobacteria (PGPR) Society India Chapter National Conference concluded in Jammu with announcement of new executive committee for 2025-2027. The conference focused on sustainable agriculture through beneficial microorganisms. [17 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/news/10th-asian-pgpr-society-india-chapter-national-conference-concludes-in-jammu-new-executive-committee-announced/",
    },

    // News Instance 10
    {
      "title":
          "Over 2 Crore Didis Have Become Lakhpatis, Number to Soon Cross 3 Crore: Shivraj Chouhan",
      "summary":
          "Union Agriculture Minister Shivraj Singh Chouhan announced that over 2 crore women (Didis) have achieved Lakhpati status through various government schemes. He projected the number will cross 3 crore soon, highlighting rural women's entrepreneurship success. [16 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/news/over-2-crore-didis-have-become-lakhpatis-number-to-soon-cross-3-crore-shivraj-chouhan/",
    },

    // News Instance 11
    {
      "title":
          "International Day of Awareness of Food Loss and Waste 2025: A Global Call to Action",
      "summary":
          "The International Day of Awareness of Food Loss and Waste 2025 highlights the urgent need to reduce food waste across the supply chain. India joins global efforts to promote sustainable food systems and minimize post-harvest losses. [15 Sep 2025]",
      "source": "Krishi Jagran",
      "url":
          "https://krishijagran.com/blog/international-day-of-awareness-of-food-loss-and-waste-2025-a-global-call-to-action-for-sustainable-food-systems/",
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
          "https://www.downtoearth.org.in/wildlife-biodiversity/crop-residue-burning-has-impacts-beyond-pollution-study-finds-disruption-in-microbial-biodiversity-increased-pests-and-fertiliser-use",
    },
    {
      "title": "Kenya turns to India for rice imports",
      "summary":
          "Unsold harvests in India prompt rice exports to Kenya amidst changing global demand. [18 Aug 2025]",
      "source": "Down To Earth",
      "url":
          "https://www.downtoearth.org.in/africa/kenya-turns-to-india-for-rice-imports-as-farmers-decry-unsold-harvests",
    },
    {
      "title": "Women farmers in Karnataka win global UN award",
      "summary":
          "A women farmers' group from Karnataka among winners of the UNDP Equator Prize 2025. [13 Aug 2025]",
      "source": "Down To Earth",
      "url":
          "https://www.downtoearth.org.in/environment/karnataka-women-farmers-group-among-global-winners-of-undp-equator-prize-2025",
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
