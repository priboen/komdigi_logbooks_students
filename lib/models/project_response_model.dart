import 'dart:convert';

class ProjectResponseModel {
    final String? message;
    final List<Project>? data;

    ProjectResponseModel({
        this.message,
        this.data,
    });

    factory ProjectResponseModel.fromJson(String str) => ProjectResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProjectResponseModel.fromMap(Map<String, dynamic> json) => ProjectResponseModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<Project>.from(json["data"]!.map((x) => Project.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
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
