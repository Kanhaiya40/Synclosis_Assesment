import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synclovis/models/Employee.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  // factory method for DatabaseHelper class
  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createNewInstance();
    return _databaseHelper;
  }

  // getting database instance
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  String employeeTable = "employee";
  String colId = 'id';
  String colName = 'name';
  String colEmail = 'email';
  String colMobile = 'mobile';
  String colPassword = 'password';

  DatabaseHelper._createNewInstance();

  // initializing database which will initiate to create database
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "employee.db";

    print("Do Something");
    var employeeDatabase =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return employeeDatabase;
  }

  // creating database here
  void _createDatabase(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $employeeTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT,$colEmail TEXT,$colMobile INTEGER,$colPassword TEXT)');
  }

  // getting list of note object from database
  Future<List<Map<String, dynamic>>> fetchNoteMapList() async {
    Database database = await this.database;

    // var result = await database
    //     .rawQuery("Select * FROM $noteTable order by $colPriority ASC");
    var result = await database.query(employeeTable, orderBy: '$colMobile ASC');
    return result;
  }

  // inserting note to database
  Future<int> saveUser(Employee emoplyee) async {
    Database insertDatabase = await this.database;
    print("Something");

    var result = await insertDatabase.insert(employeeTable, emoplyee.toJson());
    return result;
  }

  Future<Employee> getLogin(String userId, String password) async {
    Database insertDatabase = await database;
    var res = await insertDatabase.rawQuery(
        "SELECT * FROM $employeeTable WHERE $colEmail = '$userId' and $colPassword = '$password'");

    if (res.isNotEmpty) {
      return Employee.fromJson(res.first);
    }
    return null;
  }
}
