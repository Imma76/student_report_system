class Reports{
  String? name;
  String? regNo;
  String? report;
  String? reportStatus;
  List<String?>? imageUrls;
  List<String?>? videoUrls;
  List<String?>? audioUrls;

  Reports({this.audioUrls,this.imageUrls,this.name,this.regNo,this.report,this.videoUrls, this.reportStatus});


  Reports.fromJson(Map<String, dynamic> data){
    name = data['name'];
    regNo  = data['regNo'];
    report = data['report'];
    reportStatus = data['reportStatus'];
    imageUrls = data['imageUrls'];
    videoUrls = data['videoUrls'];
    audioUrls = data['audioUrls'];

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
  }

}