import 'package:flutter/material.dart';
import 'package:quran/core/constants/EducationalClassText.dart';
import 'package:quran/core/constants/fonts.dart';
import 'package:quran/data/models/main_data_model.dart';

class AttendanceListItem extends StatelessWidget {
  final StudentModel student;
  final int? selectedDelay;
  final Function(int) onSetDelay;

  const AttendanceListItem({
    super.key,
    required this.student,
    required this.selectedDelay,
    required this.onSetDelay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _statusButton(
                context,
                label: 'متأخر',
                delayValue: 500,
                textStyle: FontStyles.bodyText.copyWith(fontSize: 18),

                selected: selectedDelay,
                color: Colors.orange,
              ),
              _statusButton(
                context,
                label: 'غائب',
                delayValue: 1000,
                textStyle: FontStyles.bodyText.copyWith(fontSize: 20),
                selected: selectedDelay,
                color: Colors.pink,
              ),
              _statusButton(
                context,
                label: 'حاضر',
                delayValue: 0,
                textStyle: FontStyles.bodyText.copyWith(fontSize: 18),

                selected: selectedDelay,
                color: Colors.lightBlue,
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${student.firstName} ${student.lastName}",
                style: FontStyles.bodyText.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              EducationalClassText(classNumber: student.educationalClass),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusButton(
    BuildContext context, {
    required String label,
    required int delayValue,
    required int? selected,
    required Color color,
    required TextStyle textStyle,
  }) {
    if (delayValue == 500) {
      final isSelected = selected != null && selected > 0 && selected <= 90;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () async {
            final options = [5, 10, 15, 20, 30, 45, 60, 90];
            final chosenDelay = await showModalBottomSheet<int>(
              context: context,
              builder: (context) => ListView(
                children: options
                    .map(
                      (minute) => ListTile(
                        title: Text('متأخر $minute دقيقة'),
                        onTap: () => Navigator.pop(context, minute),
                      ),
                    )
                    .toList(),
              ),
            );

            if (chosenDelay != null) {
              onSetDelay(chosenDelay);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? color : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              isSelected ? 'متأخر ($selected د)' : label,
              style: FontStyles.bodyText.copyWith(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }

    final isSelected = delayValue == selected;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () => onSetDelay(delayValue),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            label,
            style: FontStyles.bodyText.copyWith(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
