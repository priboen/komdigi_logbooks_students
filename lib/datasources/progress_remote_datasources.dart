import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:komdigi_logbooks_students/core/constants/variables.dart';
import 'package:komdigi_logbooks_students/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_students/models/progress_response_model.dart';
import 'package:komdigi_logbooks_students/models/user_progress_response_model.dart';

class ProgressRemoteDatasources {
  Future<Either<String, GetProgressResponseModel>> getProgress(int? id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}'
    };
    final url = Uri.parse('${Variables.baseUrl}/api/progress/user/$id');

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return Right(
        GetProgressResponseModel.fromJson(
          response.body,
        ),
      );
    } else {
      return Left(
        jsonDecode(response.body)['message'],
      );
    }
  }

  Future<Either<String, Progress>> addProgress({
    required int? internshipId,
    required String? meeting,
    required String? date,
    required String? name,
    File? file,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      };
      final url = Uri.parse('${Variables.baseUrl}/api/progress/store');
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields['internship_id'] = internshipId.toString()
        ..fields['meeting'] = meeting.toString()
        ..fields['date'] = date.toString()
        ..files.add(
          await http.MultipartFile.fromPath(
            'file',
            file!.path,
          ),
        );
      final response = await request.send();
      final body = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return Right(Progress.fromJson(body));
      } else {
        return Left(jsonDecode(body)['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
