import 'dart:convert';

class InternshipResponseModel {
    final int? status;
    final String? message;
    final List<Internship>? data;

    InternshipResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory InternshipResponseModel.fromJson(String str) => InternshipResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InternshipResponseModel.fromMap(Map<String, dynamic> json) => InternshipResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Internship>.from(json["data"]!.map((x) => Internship.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Internship {
    final int? id;
    final int? leaderId;
    final int? projectId;
    final int? supervisorId;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic campus;
    final dynamic letterUrl;
    final dynamic memberPhotoUrl;
    final Leader? leader;
    final Project? project;
    final Leader? supervisor;
    final List<Leader>? members;

    Internship({
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
        this.leader,
        this.project,
        this.supervisor,
        this.members,
    });

    factory Internship.fromJson(String str) => Internship.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Internship.fromMap(Map<String, dynamic> json) => Internship(
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
        leader: json["leader"] == null ? null : Leader.fromMap(json["leader"]),
        project: json["project"] == null ? null : Project.fromMap(json["project"]),
        supervisor: json["supervisor"] == null ? null : Leader.fromMap(json["supervisor"]),
        members: json["members"] == null ? [] : List<Leader>.from(json["members"]!.map((x) => Leader.fromMap(x))),
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
        "leader": leader?.toMap(),
        "project": project?.toMap(),
        "supervisor": supervisor?.toMap(),
        "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x.toMap())),
    };
}

class Leader {
    final int? id;
    final String? name;
    final String? email;
    final DateTime? emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? phone;
    final String? roles;
    final dynamic photo;
    final Pivot? pivot;

    Leader({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.phone,
        this.roles,
        this.photo,
        this.pivot,
    });

    factory Leader.fromJson(String str) => Leader.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Leader.fromMap(Map<String, dynamic> json) => Leader(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        phone: json["phone"],
        roles: json["roles"],
        photo: json["photo"],
        pivot: json["pivot"] == null ? null : Pivot.fromMap(json["pivot"]),
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
        "pivot": pivot?.toMap(),
    };
}

class Pivot {
    final int? internshipId;
    final int? studentId;

    Pivot({
        this.internshipId,
        this.studentId,
    });

    factory Pivot.fromJson(String str) => Pivot.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
        internshipId: json["internship_id"],
        studentId: json["student_id"],
    );

    Map<String, dynamic> toMap() => {
        "internship_id": internshipId,
        "student_id": studentId,
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
