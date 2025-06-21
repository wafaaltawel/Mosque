enum AttendanceEnumStatus {
  ATTEND,
  MISSED,
  DELAY,
  NOT_TAKEN,
}

extension AttendanceEnumHelper on AttendanceEnumStatus {
  String get apiStatus => toString().split('.').last;

  int get delay {
    switch (this) {
      case AttendanceEnumStatus.ATTEND:
      case AttendanceEnumStatus.MISSED:
      case AttendanceEnumStatus.NOT_TAKEN:
        return 0;
      case AttendanceEnumStatus.DELAY:
        return 5;
    }
  }

  static AttendanceEnumStatus fromDelay(int delay) {
    if (delay == 0) return AttendanceEnumStatus.ATTEND;
    if (delay == 1000) return AttendanceEnumStatus.MISSED;
    if (delay > 0 && delay <= 90) return AttendanceEnumStatus.DELAY;
    return AttendanceEnumStatus.NOT_TAKEN;
  }
}