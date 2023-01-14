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

  Reports({this.audioUrls,this.isAnonymous,this.email,this.imageUrls,this.name,this.regNo,this.report,this.videoUrls, this.reportStatus});


  Reports.fromJson(Map<String, dynamic> data){
    name = data['name'];
    regNo  = data['regNo'];
    report = data['report'];
    reportStatus = data['reportStatus'];
    imageUrls = data['imageUrls'];
    videoUrls = data['videoUrls'];
    audioUrls = data['audioUrls'];
    isAnonymous = data['isAnonymous'];
    email=data['email'];

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
    return data;
  }

}