import 'dart:async';
import 'dart:html';
import 'quote.dart';
import 'config.dart';
import 'dart:js' as js;


// global controller
var config_c = config();
var quote_c = Quote();

void main() {
  // ini interval method
  setInterval();
  updateFavProgress();

  querySelector('#running_switch').onChange.listen((event) {
    var setTrue = false;
    if (((querySelector('#running_switch') as InputElement).value) == '1'){
      setTrue = true;
      setInterval();
    }
    config_c.setTimerStatus(setTrue);
  });

  querySelector('#fav').onClick.listen((event) {
    var uploadLimit = config_c.getUploadLimit();
    var favQuota = config_c.verifyFavQuota(quote_c);
    if  (uploadLimit > 0 && favQuota){
      config_c.setFavQuote(quote_c.toJson());
      config_c.setUploadLimit(uploadLimit-1);
      updateFav(quote_c.getId() ,quote_c.getContent(), quote_c.getAuthor());
      updateFavProgress();
      js.context.callMethod(r'$', ['#modal_obj'])
          .callMethod('modal', ['hide']);
      displayToast(1, 'Quote added to favourite successfully');
    }else if (!favQuota){
      displayToast(2, 'Already added');
    }else if (uploadLimit ==0){
      displayToast(2,'Insufficient favourite storage. Either remove some or upgrade to premium');
    }
  });
  // ensure everything is loaded before clearing all
  querySelector('#content_ready').style.display = 'block';
  querySelector('#overlay').style.display = 'none';
}

void setInterval()  {
  // Probing interval method every 5 seconds
  Timer.periodic(Duration(seconds: 1), (timer) async {
    // Off interval
    if (!config_c.getTimerStatus()) {
      timer.cancel();
    }

    // Get previous time
    var previous_time = config_c.getCaptureTime();
    var time_diff;
    // first entry
    if (previous_time == null){
      await quote_c.fetchQuote();
      config_c.setCaptureTime(DateTime.now());
      time_diff = config_c.getInterval();
      js.context.callMethod(r'$', ['#modal_obj'])
          .callMethod('modal', ['show']);
    }else{
      time_diff = (DateTime.now().difference(previous_time).inSeconds);
      if (time_diff >= config_c.getInterval()){
        await quote_c.fetchQuote();
        config_c.setCaptureTime(DateTime.now());
        js.context.callMethod(r'$', ['#modal_obj'])
            .callMethod('modal', ['show']);
      }
    }
    updateContent(config_c.getInterval() - time_diff);
  });
}

void updateContent(timer){
  (querySelector('#timer_prompt') as InputElement).value = timer.toString();
  document.querySelector('#content').innerHtml = quote_c.getContent();
  document.querySelector('#author').innerHtml = quote_c.getAuthor();
}

void displayToast(status, toast_message){
  var status_string;

  switch (status){
    case 1: {
      status_string = 'Information';
    }break;
    case 2: {
      status_string = 'Warning';
    }break;

    case 3: {
      status_string = 'Error';
    }break;
  }
  querySelector('#toast_title').innerHtml = status_string;
  querySelector('#toast_content').innerHtml = toast_message;
  js.context.callMethod(r'$', ['#toast_obj'])
      .callMethod('toast', ['show']);
}


void updateFav(qid, quote, author){
  querySelector('#card_list').innerHtml +=
  '<li id="$qid" class="list-group-item">'
      '<div class="card">'
        '<div class="card-body float-left">${quote}'
          '<footer class="blockquote-footer">'
            '<cite title="Source Title">${author}</cite>'
          '</footer>'
          '<button type="button" class="buttongroup float-right btn btn-outline-danger" value="${qid}">Remove</button>'
        '</div>'
      '</div>'
      '</li>';
  document.getElementsByClassName('buttongroup').forEach((element) {
    element.addEventListener('click', (event) {
      var id = ((element as ButtonElement).value);
      config_c.removeFavQuote(id);
      config_c.setUploadLimit(config_c.getUploadLimit()+1);
      document.getElementById(id).remove();
      updateFavProgress();
    } );
  });
}

void updateFavProgress(){
  var usage = config_c.getUploadLimit();
  var upper_limit = config_c.getBaseUploadLimit();
  var percent = ((usage)/ upper_limit) * 100;
  querySelector('#fav_count').innerHtml = '$usage/$upper_limit';
  querySelector('#fav_progress').style.width = '$percent%';
  var color;
  if (percent >= 70){
    color = '#2D90F9';
  }else if (percent >= 30 && percent < 70){
    color = '#F99F2D';
  }else{
    color = '#F9452D';
  }
  querySelector('#fav_progress').style.backgroundColor = color;
}
