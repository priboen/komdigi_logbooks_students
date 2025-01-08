import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:komdigi_logbooks_students/core/constants/variables.dart';
import 'package:komdigi_logbooks_students/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_students/models/grade_response_model.dart';

class GradeRemoteDatasources {
  Future<Either<String, GradeResponseModel>> getGrade(int? internshipId) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}'
    };
    final url = Uri.parse('${Variables.baseUrl}/api/grades/$internshipId');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return Right(
        GradeResponseModel.fromJson(
          response.body,
        ),
      );
    } else {
      return Left(
        jsonDecode(response.body)['message'],
      );
    }
  }
}
