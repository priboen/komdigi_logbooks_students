import 'dart:convert';

import 'package:komdigi_logbooks_students/models/project_response_model.dart';

class GetProgressResponseModel {
    final int? status;
    final String? message;
    final List<UserProgress>? data;

    GetProgressResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetProgressResponseModel.fromJson(String str) => GetProgressResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetProgressResponseModel.fromMap(Map<String, dynamic> json) => GetProgressResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<UserProgress>.from(json["data"]!.map((x) => UserProgress.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class UserProgress {
    final int? id;
    final String? name;
    final int? internshipId;
    final String? meeting;
    final DateTime? date;
    final String? fileUrl;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final InternProgress? internship;

    UserProgress({
        this.id,
        this.name,
        this.internshipId,
        this.meeting,
        this.date,
        this.fileUrl,
        this.createdAt,
        this.updatedAt,
        this.internship,
    });

    factory UserProgress.fromJson(String str) => UserProgress.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserProgress.fromMap(Map<String, dynamic> json) => UserProgress(
        id: json["id"],
        name: json["name"],
        internshipId: json["internship_id"],
        meeting: json["meeting"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        fileUrl: json["file_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        internship: json["internship"] == null ? null : InternProgress.fromMap(json["internship"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "internship_id": internshipId,
        "meeting": meeting,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "file_url": fileUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "internship": internship?.toMap(),
    };
}

class InternProgress {
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

    InternProgress({
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

    factory InternProgress.fromJson(String str) => InternProgress.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InternProgress.fromMap(Map<String, dynamic> json) => InternProgress(
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
