import 'package:flutter/material.dart';
class Mosque {
  final int id;
  final int organizationId;
  final String name;
  final String city;
  final String addressArea;
  final String addressDetails;
  final String contactPhone;
  final String contactEmail;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> metadata;

  Mosque({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.city,
    required this.addressArea,
    required this.addressDetails,
    required this.contactPhone,
    required this.contactEmail,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.metadata,
  });

  factory Mosque.fromJson(Map<String, dynamic> json) {
    return Mosque(
      id: json['id'],
      organizationId: json['organization_id'],
      name: json['name'],
      city: json['city'],
      addressArea: json['address_area'],
      addressDetails: json['address_details'],
      contactPhone: json['contact_phone'],
      contactEmail: json['contact_email'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      metadata: json['metadata'] ?? {},
    );
  }
}
