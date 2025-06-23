import 'package:flutter/material.dart';
import '../../../data/models/main_data_model.dart';

class ClassInfoCard extends StatelessWidget {
  final MainDataModel data;

  const ClassInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
data.groups.isNotEmpty ? data.groups[0].title : 'لا يوجد عنوان مجموعة' ,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "${data.firstName} ${data.lastName}",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
