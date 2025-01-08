import 'dart:convert';

class ProgressResponseModel {
    final int? status;
    final String? message;
    final List<Progress>? data;

    ProgressResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory ProgressResponseModel.fromJson(String str) => ProgressResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProgressResponseModel.fromMap(Map<String, dynamic> json) => ProgressResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Progress>.from(json["data"]!.map((x) => Progress.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Progress {
    final String? internshipId;
    final String? meeting;
    final DateTime? date;
    final dynamic fileUrl;
    final String? name;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Progress({
        this.internshipId,
        this.meeting,
        this.date,
        this.fileUrl,
        this.name,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Progress.fromJson(String str) => Progress.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Progress.fromMap(Map<String, dynamic> json) => Progress(
        internshipId: json["internship_id"],
        meeting: json["meeting"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        fileUrl: json["file_url"],
        name: json["name"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "internship_id": internshipId,
        "meeting": meeting,
        "date": date?.toIso8601String(),
        "file_url": fileUrl,
        "name": name,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
