class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? password;

  UserModel(
      {this.email, this.firstName, this.lastName, this.mobile, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    data['password'] = password;
    return data;
  }
}
