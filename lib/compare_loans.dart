// lib/compare_loans.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CompareLoansPage extends StatelessWidget {
  const CompareLoansPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Loans & Schemes'),
        backgroundColor: const Color.fromARGB(255, 90, 209, 104),
      ),
      backgroundColor: const Color(0xFFF6FFF6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            _SectionHeader(title: 'Major Bank Agricultural Loan Schemes'),
            const SizedBox(height: 8),
            ..._bankSchemes.map((s) => LoanCard(data: s)),
            const SizedBox(height: 16),
            _SectionHeader(title: 'Major Government Schemes'),
            const SizedBox(height: 8),
            ..._govSchemes.map((s) => LoanCard(data: s)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// small section header widget to keep the UI consistent
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF2B4705),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F3A05),
            ),
          ),
        ),
      ],
    );
  }
}

// Reusable card that displays concise info and a Know More button which opens the url
class LoanCard extends StatelessWidget {
  final Map<String, String> data;
  const LoanCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF7DF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: Color(0xFF2B4705),
                  ),
                ),
                const SizedBox(width: 12),
                // Make title and brief flexible to avoid overflow
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF123A07),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data['brief'] ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Use Wrap instead of Row so pills can wrap on small screens
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _InfoPill(label: 'Interest', value: data['interest'] ?? '-'),
                _InfoPill(label: 'Amount', value: data['amount'] ?? '-'),
                _InfoPill(label: 'Tenure', value: data['tenure'] ?? '-'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    final url = data['url'];
                    if (url != null && url.isNotEmpty) {
                      final uri = Uri.tryParse(url);
                      if (uri == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid URL')),
                        );
                        return;
                      }

                      // Directly attempt to launch externally. Avoid canLaunchUrl which
                      // may be unreliable on some Android devices/emulators.
                      try {
                        final launched = await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                        if (!launched) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not open the link.'),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to open link.')),
                        );
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF2B4705),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Know more',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String label;
  final String value;
  const _InfoPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 90),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FFF0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE6F5E6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const SizedBox(height: 2),
          SizedBox(
            width: 120,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Data maps for banks and government schemes
final List<Map<String, String>> _bankSchemes = [
  {
    'title': 'State Bank of India - Kisan Credit Card (KCC)',
    'brief':
        'Interest subvention, RuPay card & crop insurance. Popular for short-term crop credit.',
    'interest': '7% p.a. (up to ₹3 lakh)',
    'amount': '₹25,001 to no upper limit',
    'tenure': 'Up to 5 years (KCC)',
    'url':
        'https://sbi.co.in/web/agri-rural/agriculture-banking/government-schemes',
  },
  {
    'title': 'HDFC Bank - Retail Agri Loans',
    'brief': 'Digital application & quick processing for agri-business needs.',
    'interest': '9.25% - 16.05% p.a.',
    'amount': 'Up to ₹50 lakh',
    'tenure': 'Flexible',
    'url':
        'https://www.hdfcbank.com/agri/gov-schemes/agriculture-infrastructure-fund',
  },
  {
    'title': 'ICICI Bank - Farmer Finance/Krishi Loan',
    'brief': 'Whole-farm approach with flexible repayment options.',
    'interest': '9.50% - 14.85% p.a.',
    'amount': 'As per assessment',
    'tenure': '3-4 years (term loans)',
    'url': 'https://www.icicibank.com/rural/loans/farmer-finance',
  },
  {
    'title': 'Punjab National Bank - Kisan Credit Card',
    'brief': 'Government scheme participation and wide rural reach.',
    'interest': '7% p.a. (crop loans)',
    'amount': 'Need-based',
    'tenure': 'Up to 18 months (production)',
    'url': 'https://www.pnbindia.in/agriculture-loans.html',
  },
  {
    'title': 'Axis Bank - Kisan Power',
    'brief': 'Relationship manager and subsidy support for farmers.',
    'interest': '7% p.a. (up to ₹3 lakh)',
    'amount': '₹25,001 - ₹2.5 crore',
    'tenure': 'Up to 5 years',
    'url':
        'https://www.axisbank.com/agri-and-rural/loans/farmer-funding/kisan-power',
  },
  {
    'title': 'Bank of India - Kisan Credit Card',
    'brief': 'Wide rural presence with government-supported schemes.',
    'interest': '7% p.a. (up to ₹3 lakh)',
    'amount': 'Need-based',
    'tenure': 'Flexible',
    'url': 'https://bankofindia.co.in/farm-loans',
  },
  {
    'title': 'IndusInd Bank - Crop Loan',
    'brief': 'Flexible terms and option for fixed ROI.',
    'interest': '7% - 14.90% p.a.',
    'amount': 'As per profile',
    'tenure': 'Flexible',
    'url': 'https://www.indusind.bank.in/in/en/personal/loans/agri-loan.html',
  },
  {
    'title': 'Kotak Mahindra Bank - KCC',
    'brief': 'Competitive rates and flexible repayment.',
    'interest': '7% - 14% p.a.',
    'amount': 'Variable',
    'tenure': 'Variable',
    'url':
        'https://www.kotak.com/en/personal-banking/loans/kisan-credit-card.html',
  },
  {
    'title': 'Yes Bank - Commodity Finance',
    'brief': 'Quick approval for commodity financing needs.',
    'interest': 'MCLR/EBLR + 6% + tax',
    'amount': 'Up to ₹50 lakh',
    'tenure': 'Up to 11 months',
    'url': 'https://www.yesbank.in/business-banking/agri-and-food-business',
  },
  {
    'title': 'Federal Bank - Federal Green Plus Loan',
    'brief': 'Customized agricultural lending solutions.',
    'interest': 'At bank discretion',
    'amount': 'As per assessment',
    'tenure': 'Flexible',
    'url': 'https://www.federalbank.co.in/agriculture-loans',
  },
];

final List<Map<String, String>> _govSchemes = [
  {
    'title': 'PM-KISAN',
    'brief':
        'Direct income support: ₹6,000 per year in 3 installments for eligible farmers.',
    'interest': 'N/A',
    'amount': '₹6,000/year',
    'tenure': 'Ongoing scheme',
    'url': 'https://pmkisan.gov.in/',
  },
  {
    'title': 'PMFBY (Crop Insurance)',
    'brief':
        'Crop insurance that protects farmers against yield loss and crop failures.',
    'interest': 'Premiums: ~1.5% - 2% (varies)',
    'amount': 'Depends on insured sum',
    'tenure': 'Seasonal',
    'url': 'https://pmfby.gov.in/',
  },
  {
    'title': 'Kisan Credit Card (KCC) Scheme',
    'brief':
        'Short-term credit for cultivation and related needs with repayment incentives.',
    'interest': '7% p.a. (up to ₹3 lakh)',
    'amount': 'Need-based',
    'tenure': 'Short-term',
    'url': 'https://www.nabard.org/content1.aspx?id=548&catid=23&mid=23',
  },
  {
    'title': 'Agriculture Infrastructure Fund (AIF)',
    'brief':
        'Interest subvention support for infrastructure projects up to ₹2 crore.',
    'interest': '3% interest subvention',
    'amount': 'Up to ₹2 crore',
    'tenure': 'Up to 7 years',
    'url': 'https://agriinfra.dac.gov.in/',
  },
  {
    'title': 'PM KUSUM',
    'brief': 'Solarisation support with subsidy + loan structure for farmers.',
    'interest': 'Loan + subsidies',
    'amount': 'Project dependent',
    'tenure': 'Variable',
    'url': 'https://pmkusum.mnre.gov.in/',
  },
  {
    'title': 'Soil Health Card Scheme',
    'brief':
        'Free soil testing and fertilizer recommendations for higher productivity.',
    'interest': 'N/A',
    'amount': 'Services provided free',
    'tenure': 'Ongoing',
    'url': 'https://soilhealth.dac.gov.in/',
  },
  {
    'title': 'e-NAM (National Agriculture Market)',
    'brief':
        'Online trading platform to access better prices and market reach.',
    'interest': 'N/A',
    'amount': 'Market dependent',
    'tenure': 'Ongoing',
    'url': 'https://enam.gov.in/',
  },
  {
    'title': 'PMKSY (Micro-irrigation)',
    'brief':
        'Subsidies for micro-irrigation to conserve water and increase yields.',
    'interest': 'N/A',
    'amount': 'Subsidy based',
    'tenure': 'Ongoing',
    'url': 'https://pmksy.gov.in/',
  },
  {
    'title': 'NABARD Long Term Refinance',
    'brief':
        'Refinance support to banks at concessional rates to improve lending.',
    'interest': 'Refinance rate ~4.5% p.a.',
    'amount': 'Banks & institutions',
    'tenure': 'Long-term',
    'url': 'https://www.nabard.org/content.aspx?id=17',
  },
  {
    'title': 'RKVY (Rashtriya Krishi Vikas Yojana)',
    'brief': 'State-level infrastructure development funding for agriculture.',
    'interest': 'N/A',
    'amount': 'State-level schemes',
    'tenure': 'Project based',
    'url': 'https://rkvy.nic.in/',
  },
];
