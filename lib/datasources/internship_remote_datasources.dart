import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:komdigi_logbooks_students/core/constants/variables.dart';
import 'package:komdigi_logbooks_students/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_students/models/add_internship_model.dart';
import 'package:komdigi_logbooks_students/models/internship_response_model.dart';
import 'package:komdigi_logbooks_students/models/pembimbing_response_model.dart';

class InternshipRemoteDatasources {
  Future<Either<String, InternshipResponseModel>> getInternship(
    int? id,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}'
    };
    final url = Uri.parse(
      '${Variables.baseUrl}/api/internships/user/$id',
    );
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return Right(
        InternshipResponseModel.fromJson(
          response.body,
        ),
      );
    } else {
      return Left(
        jsonDecode(response.body)['message'],
      );
    }
  }

  Future<Either<String, PembimbingResponseModel>> getPembimbing() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
    final url = Uri.parse('${Variables.baseUrl}/api/supervisor');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return Right(PembimbingResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, AddInternshipResponseModel>> addInternship({
    required String leaderEmail,
    required String campusName,
    required int? projectId,
    required int? supervisorId,
    required File letterFile,
    required File memberPhotoFile,
    required List<String> memberEmails,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      };
      final url = Uri.parse('${Variables.baseUrl}/api/internships');
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields['leader_email'] = leaderEmail
        ..fields['campus'] = campusName
        ..fields['project_id'] = projectId.toString()
        ..fields['supervisor_id'] = supervisorId.toString();

      for (final email in memberEmails) {
        request.fields['member_emails[]'] = email;
      }

      request.files.add(await http.MultipartFile.fromPath(
        'letter_file',
        letterFile.path,
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'member_photo_file',
        memberPhotoFile.path,
      ));
      final response = await request.send();
      final body = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return Right(AddInternshipResponseModel.fromJson(body));
      } else {
        return Left(body);
      }
    } catch (e) {
      return Left('Terjadi kesalahan: $e');
    }
  }
}
