class Reports{
  String? name;
  String? regNo;
  String? report;
  String? reportStatus;
  List<String?>? imageUrls;
  List<String?>? videoUrls;
  List<String?>? audioUrls;
  String? email;
  bool? isAnonymous;
  String? userId;
  DateTime? createdAt;

  Reports({this.audioUrls,this.isAnonymous,this.userId,this.email,this.imageUrls,this.name,this.regNo,this.report,this.videoUrls,this.createdAt, this.reportStatus});


  Reports.fromJson(Map<String, dynamic> data){
    name = data['name'];
    regNo  = data['regNo'];
    report = data['report'];
    reportStatus = data['reportStatus'];
    imageUrls = List.from(data['imageUrls']);
    videoUrls = List.from(data['videoUrls']);
    audioUrls = List.from(data['audioUrls']);
    isAnonymous = data['isAnonymous'];
    email=data['email'];
    userId= data['userId'];
    createdAt= DateTime.parse(data['createdAt'].toDate().toString());

  }

  toJson(){
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['regNo'] = regNo;
    data['report'] = report;
    data['reportStatus'] = reportStatus;
    data['imageUrls'] = imageUrls;
    data['videoUrls']= videoUrls;
    data['audioUrls'] = audioUrls;
    data['isAnonymous'] = isAnonymous;
    data['email']= email;
    data['userId'] = userId;
    data['createdAt']= createdAt;
    data['reportStatus']=reportStatus;
    return data;
  }

}