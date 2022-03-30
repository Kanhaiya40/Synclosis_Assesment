import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synclovis/apis/api_service.dart';

import '../models/employee_details_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapData) {
            if (snapData.connectionState == ConnectionState.none ||
                snapData.hasData == null) {
              //print('project snapshot data is: ${projectSnap.data}');
              return Container();
            }
            return ListView.builder(
              itemCount: snapData.data.length,
              itemBuilder: (context, index) {
                Data employee = snapData.data[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(employee.profileImage),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Employee Name :"),
                            Text("${employee.employeeName}")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Employee Salary :"),
                            Text("${employee.employeeSalary}")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Employee Age :"),
                            Text("${employee.employeeAge}")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Widget to display the list of project
                      ],
                    ),
                  ),
                );
              },
            );
          },
          future: EmployeeServices().getEmployees(),
        ),
      ),
    );
  }
}
