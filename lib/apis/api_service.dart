import 'dart:convert';

import 'package:http/http.dart';
import 'package:synclovis/apis/api_const.dart';

import '../models/employee_details_response.dart';

class EmployeeServices {
  Future<List<Data>> getEmployees() async {
    Response res = await get(Uri.parse(employeeListEndPoint));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      EmployeeDetails employeeDetails = EmployeeDetails.fromJson(body);
      List<Data> employees = employeeDetails.data;

      return employees;
    } else {
      throw "Unable to retrieve employee List.";
    }
  }
}
