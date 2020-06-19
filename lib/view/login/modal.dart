

class UserData {
  String token;
  String username;
  String email;
  int user;
  String userType;

  UserData({
    this.token,
    this.user,
    this.userType,
    this.username,
    this.email
  });

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'];
    userType = json['user_type'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user'] = this.user;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['username'] = this.username;
    return data;
  }
}

class SendData {
  final String type;
  final String value;

  SendData({
    this.type,
    this.value
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }

}