class User{
   String? name;
   String? mobile;
   String? userId;
   String? email;
   String? regNo;

  User({this.regNo,this.name,this.email,this.mobile,this.userId});

  fromJson(Map<String, dynamic> data){
    name = data['name'];
    mobile = data['mobile'];
    email = data['email'];
    regNo= data['regNo'];
  }
  toJson(){
    Map<String,dynamic> data={};
    data['regNo']= regNo;
    data['mobile']= mobile;
    data['email'] = email;
    data['name'] = name;
    return data;

  }
}