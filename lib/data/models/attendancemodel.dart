class AttendanceModel {
  final int studentId;
  final int campaignId;
  final int groupId;
  final DateTime takenDate;
  final int delay;

  AttendanceModel({
    required this.studentId,
    required this.campaignId,
    required this.groupId,
    required this.takenDate,
    required this.delay,
  });

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "campaign_id": campaignId,
    "group_id": groupId,
    "taken_date": takenDate.toIso8601String(),
    "delay": delay,
  };
}
