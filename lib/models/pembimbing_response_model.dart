import 'dart:convert';

class PembimbingResponseModel {
    final String? message;
    final List<Pembimbing>? data;

    PembimbingResponseModel({
        this.message,
        this.data,
    });

    factory PembimbingResponseModel.fromJson(String str) => PembimbingResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PembimbingResponseModel.fromMap(Map<String, dynamic> json) => PembimbingResponseModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<Pembimbing>.from(json["data"]!.map((x) => Pembimbing.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Pembimbing {
    final int? id;
    final String? name;
    final String? email;
    final dynamic emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? phone;
    final String? roles;
    final String? photo;

    Pembimbing({
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

    factory Pembimbing.fromJson(String str) => Pembimbing.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pembimbing.fromMap(Map<String, dynamic> json) => Pembimbing(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
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
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "phone": phone,
        "roles": roles,
        "photo": photo,
    };
}
