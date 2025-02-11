import 'dart:convert';

import 'package:komdigi_logbooks_students/models/project_response_model.dart';

class PersonalInternshipResponseModel {
    final String? message;
    final Data? data;

    PersonalInternshipResponseModel({
        this.message,
        this.data,
    });

    factory PersonalInternshipResponseModel.fromJson(String str) => PersonalInternshipResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PersonalInternshipResponseModel.fromMap(Map<String, dynamic> json) => PersonalInternshipResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data?.toMap(),
    };
}

class Data {
    final int? leaderId;
    final String? projectId;
    final String? supervisorId;
    final DateTime? startDate;
    final DateTime? endDate;
    final String? campus;
    final String? status;
    final String? letterUrl;
    final String? memberPhotoUrl;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;
    final InternshipMember? leader;
    final Project? project;
    final InternshipMember? supervisor;

    Data({
        this.leaderId,
        this.projectId,
        this.supervisorId,
        this.startDate,
        this.endDate,
        this.campus,
        this.status,
        this.letterUrl,
        this.memberPhotoUrl,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.leader,
        this.project,
        this.supervisor,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        leaderId: json["leader_id"],
        projectId: json["project_id"],
        supervisorId: json["supervisor_id"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        campus: json["campus"],
        status: json["status"],
        letterUrl: json["letter_url"],
        memberPhotoUrl: json["member_photo_url"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        leader: json["leader"] == null ? null : InternshipMember.fromMap(json["leader"]),
        project: json["project"] == null ? null : Project.fromMap(json["project"]),
        supervisor: json["supervisor"] == null ? null : InternshipMember.fromMap(json["supervisor"]),
    );

    Map<String, dynamic> toMap() => {
        "leader_id": leaderId,
        "project_id": projectId,
        "supervisor_id": supervisorId,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "campus": campus,
        "status": status,
        "letter_url": letterUrl,
        "member_photo_url": memberPhotoUrl,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "leader": leader?.toMap(),
        "project": project?.toMap(),
        "supervisor": supervisor?.toMap(),
    };
}

class InternshipMember {
    final int? id;
    final String? name;
    final String? email;
    final DateTime? emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? phone;
    final String? roles;
    final dynamic photo;

    InternshipMember({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.phone,
        this.roles,
        this.photo,
    });

    factory InternshipMember.fromJson(String str) => InternshipMember.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InternshipMember.fromMap(Map<String, dynamic> json) => InternshipMember(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        phone: json["phone"],
        roles: json["roles"],
        photo: json["photo"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "phone": phone,
        "roles": roles,
        "photo": photo,
    };
}