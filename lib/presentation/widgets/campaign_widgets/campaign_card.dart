import 'package:flutter/material.dart';
import 'package:quran/data/models/campaign.dart';

// import 'package:intl/intl.dart' as intl;
import 'package:quran/session_manager.dart';

class CampaignCard extends StatelessWidget {
  final Campaign campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    final readableDays = campaign.days.replaceAll(",", "، ");
    final isActive = true; // Adjust if backend includes status field
    final cardColor =   const Color(0xFFD3F3F4);
    final statusColor =  Colors.lightBlue ;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          campaign.name,
          textDirection: TextDirection.rtl,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 12),
            Text("الأيام: $readableDays", textDirection: TextDirection.rtl),
            const SizedBox(height: 8),
            Text("المسجد: ${campaign.mosque.name}", textDirection: TextDirection.rtl),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isActive ? "الدورة قائمة" : "منتهية",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        onTap: () async {
          await SessionManager.saveCampaignId(campaign.id);
          Navigator.pushNamed(context, '/select-groups');
        },
      ),
    );
  }
}
