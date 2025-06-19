enum AttendanceEnumStatus {
  present,
  late,
  absent;

  int get delay {
    switch (this) {
      case AttendanceEnumStatus.present:
        return 0;
      case AttendanceEnumStatus.late:
        return 500;
      case AttendanceEnumStatus.absent:
        return 1000;
    }
  }
}
