class TeacherModel {
  final int id;
  final String? educationalLevel;
  final String? universityName;
  final String? collegeName;
  final String firstName;
  final String lastName;
  final String? birthDate;
  final String mobilePhoneNumber;
  final bool? inAnotherMosque;
  final String? otherMosqueNames;
  final String? specialTalent;
  final String? fatherName;
  final String? addressArea;
  final String? addressStreet;
  final String? addressBuilding;
  final String? preservedParts;
  final String? partsTestedByEndowments;
  final String? imageUrl;
  final bool? isMojaz;
  final bool? isWorking;
  final String? jobRole;
  final String? workplaceName;
  final String? password;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String userType;

  TeacherModel({
    required this.id,
    required this.educationalLevel,
    required this.universityName,
    required this.collegeName,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.mobilePhoneNumber,
    required this.inAnotherMosque,
    required this.otherMosqueNames,
    required this.specialTalent,
    required this.fatherName,
    required this.addressArea,
    required this.addressStreet,
    required this.addressBuilding,
    required this.preservedParts,
    required this.partsTestedByEndowments,
    required this.imageUrl,
    required this.isMojaz,
    required this.isWorking,
    required this.jobRole,
    required this.workplaceName,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.userType,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
  try {
    return TeacherModel(
      id: json['id'] ?? 0,
      educationalLevel: json['educational_level'],
      universityName: json['university_name'],
      collegeName: json['college_name'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      birthDate: json['birth_date'],
      mobilePhoneNumber: json['mobile_phone_number'] ?? '',
      inAnotherMosque: json['in_another_mosque'],
      otherMosqueNames: json['other_mosque_names'],
      specialTalent: json['special_talent'],
      fatherName: json['father_name'],
      addressArea: json['current_residence_address_area'],
      addressStreet: json['current_residence_address_street'],
      addressBuilding: json['current_residence_address_building'],
      preservedParts: json['preserved_parts'],
      partsTestedByEndowments: json['parts_tested_by_the_endowments'],
      imageUrl: json['image_url'],
      isMojaz: json['is_mojaz'],
      isWorking: json['is_working'],
      jobRole: json['job_role'],
      workplaceName: json['workplace_name'],
      password: json['password'],
      role: json['role'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      userType: json['userType'] ?? '',
    );
  } catch (e) {
    print('❌ خطأ في fromJson: $e');
    rethrow;
  }
}

}
