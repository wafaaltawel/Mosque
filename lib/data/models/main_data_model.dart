// class MainDataModel {
//   final int id;
//   final String? educationalLevel;
//   final String? universityName;
//   final String? collegeName;
//   final String firstName;
//   final String lastName;
//   final String? birthDate;
//   final String mobilePhoneNumber;
//   final bool? inAnotherMosque;
//   final String? otherMosqueNames;
//   final String? specialTalent;
//   final String? fatherName;
//   final String? currentResidenceAddressArea;
//   final String? currentResidenceAddressStreet;
//   final String? currentResidenceAddressBuilding;
//   final String? preservedParts;
//   final String? partsTestedByTheEndowments;
//   final String? imageUrl;
//   final bool? isMojaz;
//   final bool? isWorking;
//   final String? jobRole;
//   final String? workplaceName;
//   final String password;
//   final String role;
//   final String createdAt;
//   final String updatedAt;
//   final List<GroupModel> groups;

//   MainDataModel({
//     required this.id,
//     this.educationalLevel,
//     this.universityName,
//     this.collegeName,
//     required this.firstName,
//     required this.lastName,
//     this.birthDate,
//     required this.mobilePhoneNumber,
//     this.inAnotherMosque,
//     this.otherMosqueNames,
//     this.specialTalent,
//     this.fatherName,
//     this.currentResidenceAddressArea,
//     this.currentResidenceAddressStreet,
//     this.currentResidenceAddressBuilding,
//     this.preservedParts,
//     this.partsTestedByTheEndowments,
//     this.imageUrl,
//     this.isMojaz,
//     this.isWorking,
//     this.jobRole,
//     this.workplaceName,
//     required this.password,
//     required this.role,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.groups,
//   });

//   factory MainDataModel.fromJson(Map<String, dynamic> json) {
//     return MainDataModel(
//       id: json['id'] ?? 0,
//       educationalLevel: json['educational_level'] as String?,
//       universityName: json['university_name'] as String?,
//       collegeName: json['college_name'] as String?,
//       firstName: json['first_name'] ?? '',
//       lastName: json['last_name'] ?? '',
//       birthDate: json['birth_date'] as String?,
//       mobilePhoneNumber: json['mobile_phone_number'] ?? '',
//       inAnotherMosque: json['in_another_mosque'] as bool?,
//       otherMosqueNames: json['other_mosque_names'] as String?,
//       specialTalent: json['special_talent'] as String?,
//       fatherName: json['father_name'] as String?,
//       currentResidenceAddressArea:
//           json['current_residence_address_area'] as String?,
//       currentResidenceAddressStreet:
//           json['current_residence_address_street'] as String?,
//       currentResidenceAddressBuilding:
//           json['current_residence_address_building'] as String?,
//       preservedParts: json['preserved_parts'] as String?,
//       partsTestedByTheEndowments:
//           json['parts_tested_by_the_endowments'] as String?,
//       imageUrl: json['image_url'] as String?,
//       isMojaz: json['is_mojaz'] as bool?,
//       isWorking: json['is_working'] as bool?,
//       jobRole: json['job_role'] as String?,
//       workplaceName: json['workplace_name'] as String?,
//       password: json['password'] ?? '',
//       role: json['role'] ?? '',
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//       groups: (json['groups'] as List<dynamic>? ?? [])
//           .map((e) => GroupModel.fromJson(e))
//           .toList(),
//     );
//   }
// }

// class GroupModel {
//   final int id;
//   final String title;
//   final int groupClass; // بدلًا من 'class'
//   final int currentTeacherId;
//   final String createdAt;
//   final String updatedAt;
//   final List<StudentModel> students;

//   GroupModel({
//     required this.id,
//     required this.title,
//     required this.groupClass,
//     required this.currentTeacherId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.students,
//   });

//   factory GroupModel.fromJson(Map<String, dynamic> json) {
//     return GroupModel(
//       id: json['id'] ?? 0,
//       title: json['title'] ?? '',
//       groupClass: json['class'] ?? 0,
//       currentTeacherId: json['currentTeacherId'] ?? 0,
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       students: (json['students'] as List<dynamic>? ?? [])
//           .map((e) => StudentModel.fromJson(e))
//           .toList(),
//     );
//   }
// }

// class StudentModel {
//   final int id;
//   final String? currentMosqueName;
//   final String? educationalClass;
//   final String firstName;
//   final String? lastName;
//   final String? birthDate;
//   final String studentMobile;
//   final String? school;
//   final bool inAnotherMosque;
//   final String? otherMosqueNames;
//   final String? studentHealthStatus;
//   final String? specialTalent;
//   final String? fatherName;
//   final String? fatherStatus;
//   final String? fatherJob;
//   final String? fatherIncomeLevel;
//   final String? fatherEducationLevel;
//   final String? fatherHealthStatus;
//   final String? fatherPhoneNumber;
//   final String? fatherWorkNumber;
//   final String? motherName;
//   final String? motherStatus;
//   final String? motherJob;
//   final String? motherIncomeLevel;
//   final String? motherEducationLevel;
//   final String? motherHealthStatus;
//   final String? motherPhoneNumber;
//   final String? motherHomeNumber;
//   final String? parentMaritalStatus;
//   final String? studentMobileNumber;
//   final String? studentHomeNumber;
//   final String? originalResidenceAddressArea;
//   final String? originalResidenceAddressStreet;
//   final String? originalResidenceAddressBuilding;
//   final String? originalResidenceAddressFloor;
//   final String? currentResidenceAddressArea;
//   final String? currentResidenceAddressStreet;
//   final String? currentResidenceAddressBuilding;
//   final String? currentResidenceAddressFloor;
//   final String? preservedParts;
//   final String? partsTestedByTheEndowments;
//   final String? imageUrl;
//   final String password;
//   final String createdAt;
//   final String updatedAt;

//   StudentModel({
//     required this.id,
//     this.currentMosqueName,
//     this.educationalClass,
//     required this.firstName,
//     this.lastName,
//     this.birthDate,
//     required this.studentMobile,
//     this.school,
//     required this.inAnotherMosque,
//     this.otherMosqueNames,
//     this.studentHealthStatus,
//     this.specialTalent,
//     this.fatherName,
//     this.fatherStatus,
//     this.fatherJob,
//     this.fatherIncomeLevel,
//     this.fatherEducationLevel,
//     this.fatherHealthStatus,
//     this.fatherPhoneNumber,
//     this.fatherWorkNumber,
//     this.motherName,
//     this.motherStatus,
//     this.motherJob,
//     this.motherIncomeLevel,
//     this.motherEducationLevel,
//     this.motherHealthStatus,
//     this.motherPhoneNumber,
//     this.motherHomeNumber,
//     this.parentMaritalStatus,
//     this.studentMobileNumber,
//     this.studentHomeNumber,
//     this.originalResidenceAddressArea,
//     this.originalResidenceAddressStreet,
//     this.originalResidenceAddressBuilding,
//     this.originalResidenceAddressFloor,
//     this.currentResidenceAddressArea,
//     this.currentResidenceAddressStreet,
//     this.currentResidenceAddressBuilding,
//     this.currentResidenceAddressFloor,
//     this.preservedParts,
//     this.partsTestedByTheEndowments,
//     this.imageUrl,
//     required this.password,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory StudentModel.fromJson(Map<String, dynamic> json) {
//     return StudentModel(
//       id: json['id'] ?? 0,
//       currentMosqueName: json['current_mosque_name'] as String?,
//       educationalClass: json['educational_class']?.toString(),
//       firstName: json['first_name'] ?? '',
//       lastName: json['last_name'] as String?,
//       birthDate: json['birth_date'] as String?,
//       studentMobile: json['student_mobile'] ?? '',
//       school: json['school'] as String?,
//       inAnotherMosque: json['in_another_mosque'] ?? false,
//       otherMosqueNames: json['other_mosque_names'] as String?,
//       studentHealthStatus: json['student_health_status'] as String?,
//       specialTalent: json['special_talent'] as String?,
//       fatherName: json['father_name'] as String?,
//       fatherStatus: json['father_status'] as String?,
//       fatherJob: json['father_job'] as String?,
//       fatherIncomeLevel: json['father_income_level'] as String?,
//       fatherEducationLevel: json['father_education_level'] as String?,
//       fatherHealthStatus: json['father_health_status'] as String?,
//       fatherPhoneNumber: json['father_phone_number'] as String?,
//       fatherWorkNumber: json['father_work_number'] as String?,
//       motherName: json['mother_name'] as String?,
//       motherStatus: json['mother_status'] as String?,
//       motherJob: json['mother_job'] as String?,
//       motherIncomeLevel: json['mother_income_level'] as String?,
//       motherEducationLevel: json['mother_education_level'] as String?,
//       motherHealthStatus: json['mother_health_status'] as String?,
//       motherPhoneNumber: json['mother_phone_number'] as String?,
//       motherHomeNumber: json['mother_home_number'] as String?,
//       parentMaritalStatus: json['parent_marital_status'] as String?,
//       studentMobileNumber: json['student_mobile_number'] as String?,
//       studentHomeNumber: json['student_home_number'] as String?,
//       originalResidenceAddressArea:
//           json['original_residence_address_area'] as String?,
//       originalResidenceAddressStreet:
//           json['original_residence_address_street'] as String?,
//       originalResidenceAddressBuilding:
//           json['original_residence_address_building'] as String?,
//       originalResidenceAddressFloor:
//           json['original_residence_address_floor'] as String?,
//       currentResidenceAddressArea:
//           json['current_residence_address_area'] as String?,
//       currentResidenceAddressStreet:
//           json['current_residence_address_street'] as String?,
//       currentResidenceAddressBuilding:
//           json['current_residence_address_building'] as String?,
//       currentResidenceAddressFloor:
//           json['current_residence_address_floor'] as String?,
//       preservedParts: json['preserved_parts'] as String?,
//       partsTestedByTheEndowments:
//           json['parts_tested_by_the_endowments'] as String?,
//       imageUrl: json['image_url'] as String?,
//       password: json['password'] ?? '',
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//     );
//   }
// }

class MainDataModel {
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
  final String? currentResidenceAddressArea;
  final String? currentResidenceAddressStreet;
  final String? currentResidenceAddressBuilding;
  final String? preservedParts;
  final String? partsTestedByTheEndowments;
  final String? imageUrl;
  final bool? isMojaz;
  final bool? isWorking;
  final String? jobRole;
  final String? workplaceName;
  final String password;
  final String role;
  final String createdAt;
  final String updatedAt;
  final List<GroupModel> groups;

  MainDataModel({
    required this.id,
    this.educationalLevel,
    this.universityName,
    this.collegeName,
    required this.firstName,
    required this.lastName,
    this.birthDate,
    required this.mobilePhoneNumber,
    this.inAnotherMosque,
    this.otherMosqueNames,
    this.specialTalent,
    this.fatherName,
    this.currentResidenceAddressArea,
    this.currentResidenceAddressStreet,
    this.currentResidenceAddressBuilding,
    this.preservedParts,
    this.partsTestedByTheEndowments,
    this.imageUrl,
    this.isMojaz,
    this.isWorking,
    this.jobRole,
    this.workplaceName,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.groups,
  });

  factory MainDataModel.fromJson(Map<String, dynamic> json) {
    return MainDataModel(
      id: json['id'] ?? 0,
      educationalLevel: json['educational_level'] as String?,
      universityName: json['university_name'] as String?,
      collegeName: json['college_name'] as String?,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      birthDate: json['birth_date'] as String?,
      mobilePhoneNumber: json['mobile_phone_number'] ?? '',
      inAnotherMosque: json['in_another_mosque'] as bool?,
      otherMosqueNames: json['other_mosque_names'] as String?,
      specialTalent: json['special_talent'] as String?,
      fatherName: json['father_name'] as String?,
      currentResidenceAddressArea: json['current_residence_address_area'] as String?,
      currentResidenceAddressStreet: json['current_residence_address_street'] as String?,
      currentResidenceAddressBuilding: json['current_residence_address_building'] as String?,
      preservedParts: json['preserved_parts'] as String?,
      partsTestedByTheEndowments: json['parts_tested_by_the_endowments'] as String?,
      imageUrl: json['image_url'] as String?,
      isMojaz: json['is_mojaz'] as bool?,
      isWorking: json['is_working'] as bool?,
      jobRole: json['job_role'] as String?,
      workplaceName: json['workplace_name'] as String?,
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      groups: (json['groups'] as List<dynamic>? ?? [])
          .map((e) => GroupModel.fromJson(e))
          .toList(),
    );
  }
}
class GroupModel {
  final int id;
  final String title;
  final int groupClass; // بدلًا من 'class'
  final int currentTeacherId;
  final String createdAt;
  final String updatedAt;
  final List<StudentModel> students;

  GroupModel({
    required this.id,
    required this.title,
    required this.groupClass,
    required this.currentTeacherId,
    required this.createdAt,
    required this.updatedAt,
    required this.students,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      groupClass: json['class'] ?? 0,
      currentTeacherId: json['currentTeacherId'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      students: (json['students'] as List<dynamic>? ?? [])
          .map((e) => StudentModel.fromJson(e))
          .toList(),
    );
  }
}
class StudentModel {
  final int id;
  final String? currentMosqueName;
  final String? educationalClass;
  final String firstName;
  final String? lastName;
  final String? birthDate;
  final String studentMobile;
  final String? school;
  final bool inAnotherMosque;
  final String? otherMosqueNames;
  final String? studentHealthStatus;
  final String? specialTalent;
  final String? fatherName;
  final String? fatherStatus;
  final String? fatherJob;
  final String? fatherIncomeLevel;
  final String? fatherEducationLevel;
  final String? fatherHealthStatus;
  final String? fatherPhoneNumber;
  final String? fatherWorkNumber;
  final String? motherName;
  final String? motherStatus;
  final String? motherJob;
  final String? motherIncomeLevel;
  final String? motherEducationLevel;
  final String? motherHealthStatus;
  final String? motherPhoneNumber;
  final String? motherHomeNumber;
  final String? parentMaritalStatus;
  final String? studentMobileNumber;
  final String? studentHomeNumber;
  final String? originalResidenceAddressArea;
  final String? originalResidenceAddressStreet;
  final String? originalResidenceAddressBuilding;
  final String? originalResidenceAddressFloor;
  final String? currentResidenceAddressArea;
  final String? currentResidenceAddressStreet;
  final String? currentResidenceAddressBuilding;
  final String? currentResidenceAddressFloor;
  final String? preservedParts;
  final String? partsTestedByTheEndowments;
  final String? imageUrl;
  final String password;
  final String createdAt;
  final String updatedAt;

  StudentModel({
    required this.id,
    this.currentMosqueName,
    this.educationalClass,
    required this.firstName,
    this.lastName,
    this.birthDate,
    required this.studentMobile,
    this.school,
    required this.inAnotherMosque,
    this.otherMosqueNames,
    this.studentHealthStatus,
    this.specialTalent,
    this.fatherName,
    this.fatherStatus,
    this.fatherJob,
    this.fatherIncomeLevel,
    this.fatherEducationLevel,
    this.fatherHealthStatus,
    this.fatherPhoneNumber,
    this.fatherWorkNumber,
    this.motherName,
    this.motherStatus,
    this.motherJob,
    this.motherIncomeLevel,
    this.motherEducationLevel,
    this.motherHealthStatus,
    this.motherPhoneNumber,
    this.motherHomeNumber,
    this.parentMaritalStatus,
    this.studentMobileNumber,
    this.studentHomeNumber,
    this.originalResidenceAddressArea,
    this.originalResidenceAddressStreet,
    this.originalResidenceAddressBuilding,
    this.originalResidenceAddressFloor,
    this.currentResidenceAddressArea,
    this.currentResidenceAddressStreet,
    this.currentResidenceAddressBuilding,
    this.currentResidenceAddressFloor,
    this.preservedParts,
    this.partsTestedByTheEndowments,
    this.imageUrl,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] ?? 0,
      currentMosqueName: json['current_mosque_name'] as String?,
      educationalClass: json['educational_class']?.toString(),
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] as String?,
      birthDate: json['birth_date'] as String?,
      studentMobile: json['student_mobile'] ?? '',
      school: json['school'] as String?,
      inAnotherMosque: json['in_another_mosque'] ?? false,
      otherMosqueNames: json['other_mosque_names'] as String?,
      studentHealthStatus: json['student_health_status'] as String?,
      specialTalent: json['special_talent'] as String?,
      fatherName: json['father_name'] as String?,
      fatherStatus: json['father_status'] as String?,
      fatherJob: json['father_job'] as String?,
      fatherIncomeLevel: json['father_income_level'] as String?,
      fatherEducationLevel: json['father_education_level'] as String?,
      fatherHealthStatus: json['father_health_status'] as String?,
      fatherPhoneNumber: json['father_phone_number'] as String?,
      fatherWorkNumber: json['father_work_number'] as String?,
      motherName: json['mother_name'] as String?,
      motherStatus: json['mother_status'] as String?,
      motherJob: json['mother_job'] as String?,
      motherIncomeLevel: json['mother_income_level'] as String?,
      motherEducationLevel: json['mother_education_level'] as String?,
      motherHealthStatus: json['mother_health_status'] as String?,
      motherPhoneNumber: json['mother_phone_number'] as String?,
      motherHomeNumber: json['mother_home_number'] as String?,
      parentMaritalStatus: json['parent_marital_status'] as String?,
      studentMobileNumber: json['student_mobile_number'] as String?,
      studentHomeNumber: json['student_home_number'] as String?,
      originalResidenceAddressArea: json['original_residence_address_area'] as String?,
      originalResidenceAddressStreet: json['original_residence_address_street'] as String?,
      originalResidenceAddressBuilding: json['original_residence_address_building'] as String?,
      originalResidenceAddressFloor: json['original_residence_address_floor'] as String?,
      currentResidenceAddressArea: json['current_residence_address_area'] as String?,
      currentResidenceAddressStreet: json['current_residence_address_street'] as String?,
      currentResidenceAddressBuilding: json['current_residence_address_building'] as String?,
      currentResidenceAddressFloor: json['current_residence_address_floor'] as String?,
      preservedParts: json['preserved_parts'] as String?,
      partsTestedByTheEndowments: json['parts_tested_by_the_endowments'] as String?,
      imageUrl: json['image_url'] as String?,
      password: json['password'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
