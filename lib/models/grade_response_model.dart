import 'dart:convert';

class GradeResponseModel {
    final int? status;
    final String? message;
    final Grade? data;

    GradeResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory GradeResponseModel.fromJson(String str) => GradeResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GradeResponseModel.fromMap(Map<String, dynamic> json) => GradeResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Grade.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class Grade {
    final int? id;
    final int? internshipId;
    final String? gradeUrl;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final GradeInternship? internship;

    Grade({
        this.id,
        this.internshipId,
        this.gradeUrl,
        this.createdAt,
        this.updatedAt,
        this.internship,
    });

    factory Grade.fromJson(String str) => Grade.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Grade.fromMap(Map<String, dynamic> json) => Grade(
        id: json["id"],
        internshipId: json["internship_id"],
        gradeUrl: json["grade_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        internship: json["internship"] == null ? null : GradeInternship.fromMap(json["internship"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "internship_id": internshipId,
        "grade_url": gradeUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "internship": internship?.toMap(),
    };
}

class GradeInternship {
    final int? id;
    final int? leaderId;
    final int? projectId;
    final int? supervisorId;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? campus;
    final String? letterUrl;
    final String? memberPhotoUrl;
    final Project? project;

    GradeInternship({
        this.id,
        this.leaderId,
        this.projectId,
        this.supervisorId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.campus,
        this.letterUrl,
        this.memberPhotoUrl,
        this.project,
    });

    factory GradeInternship.fromJson(String str) => GradeInternship.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GradeInternship.fromMap(Map<String, dynamic> json) => GradeInternship(
        id: json["id"],
        leaderId: json["leader_id"],
        projectId: json["project_id"],
        supervisorId: json["supervisor_id"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        campus: json["campus"],
        letterUrl: json["letter_url"],
        memberPhotoUrl: json["member_photo_url"],
        project: json["project"] == null ? null : Project.fromMap(json["project"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "leader_id": leaderId,
        "project_id": projectId,
        "supervisor_id": supervisorId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "campus": campus,
        "letter_url": letterUrl,
        "member_photo_url": memberPhotoUrl,
        "project": project?.toMap(),
    };
}

class Project {
    final int? id;
    final String? name;
    final String? features;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Project({
        this.id,
        this.name,
        this.features,
        this.createdAt,
        this.updatedAt,
    });

    factory Project.fromJson(String str) => Project.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Project.fromMap(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        features: json["features"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "features": features,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
