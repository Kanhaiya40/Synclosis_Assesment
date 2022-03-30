class Employee {
  int id;
  String name;
  String email;
  String mobile;
  String password;

  Employee.withId({this.id, this.name, this.email, this.mobile, this.password});


  Employee(this.name, this.email, this.mobile, this.password);

  Employee.fromJson(Map<String, dynamic> json) {
    if (id != null) {
      json['id'] = id;
    }
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    return data;
  }
}
