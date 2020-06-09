import 'quote.dart';

class config{
  var _base_upload_limit = 10;
  var _premium = false;
  var _account_id;
  var _interval = 10;
  var _upload_limit = 10;
  var _isStopped = true;
  var _captureTime;
  List <Map> _collection = [];

  int getBaseUploadLimit(){ return _base_upload_limit; }

  bool getPremiumStatus(){ return _premium; }

  String getAccountId(){ return _account_id;}

  int getInterval(){ return _interval;}

  int getUploadLimit(){ return _upload_limit; }

  bool getTimerStatus(){ return _isStopped; }

  DateTime getCaptureTime(){ return _captureTime; }

  List getFavQuote() { return _collection; }

  void setPremiumStatus(premium){ _premium = premium ; }

  void setAccountId(account_id){ _account_id = account_id;}

  void setInterval(interval){ _interval = interval;}

  void setUploadLimit(upload_limit){ _upload_limit = upload_limit; }

  void setTimerStatus(toggle){ _isStopped = toggle; }

  void setCaptureTime (captureTime){ _captureTime = captureTime; }

  void setFavQuote(quote){ _collection.add(quote); }

  bool verifyFavQuota(quote){
    var returnVal = true;
    _collection.forEach((element) {
      var temp = Quote();
      temp.fromJson(element);
      if (temp.getId() == quote.getId()){
        returnVal = false;
      }
    });
    return returnVal;
  }

  void removeFavQuote(id){
    for (var x in _collection.toList()){
      var temp = Quote();
      temp.fromJson(x);
      if (temp.getId().toString() == id){
        _collection.remove(x);
      }
    }
  }

  double percentProgress(){
    return ((_upload_limit)/ _base_upload_limit) * 100;
  }

  String colorProgress(percent){
    var color;
    if (percent >= 70){
      color = '#2D90F9';
    }else if (percent >= 30 && percent < 70){
      color = '#F99F2D';
    }else{
      color = '#F9452D';
    }
    return color;
  }
}
