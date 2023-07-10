class Reports{
  String? name;
  String? regNo;
  String? report;
  String? reportStatus;
  List<String?>? imageUrls;
  List<String?>? videoUrls;
  List<String?>? audioUrls;
  String? email;
  String? phone;
  String? fcmToken;
  bool? isAnonymous;
  String? userId;
  DateTime? createdAt;

  Reports({this.audioUrls,this.fcmToken
    ,this.isAnonymous,this.phone,this.userId,this.email,this.imageUrls,this.name,this.regNo,this.report,this.videoUrls,this.createdAt, this.reportStatus});


  Reports.fromJson(Map<String, dynamic> data){
    name = data['name'];
    fcmToken = data['fcmToken'];
    regNo  = data['regNo'];
    report = data['report'];
    reportStatus = data['reportStatus'];
    imageUrls = List.from(data['imageUrls']);
    videoUrls = List.from(data['videoUrls']);
    audioUrls = List.from(data['audioUrls']);
    isAnonymous = data['isAnonymous'];
    email=data['email'];
    phone = data['phone'];
    userId= data['userId'];
    createdAt= DateTime.parse(data['createdAt'].toDate().toString());

  }

  toJson(){
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['regNo'] = regNo;

    data['fcmToken'] = fcmToken;
    data['report'] = report;
    data['reportStatus'] = reportStatus;
    data['imageUrls'] = imageUrls;
    data['videoUrls']= videoUrls;
    data['audioUrls'] = audioUrls;
    data['isAnonymous'] = isAnonymous;
    data['email']= email;
    data['phone']= phone;
    data['userId'] = userId;
    data['createdAt']= createdAt;
    data['reportStatus']=reportStatus;
    return data;
  }

}