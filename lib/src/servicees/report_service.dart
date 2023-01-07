import '../collections/collections.dart';
import '../models/report.dart';

class ReportService{

  Future<bool> createReport(Reports reportModel)async{
    try{
      final response = await Collections.reportCollection.add(reportModel.toJson());
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }

  }
}