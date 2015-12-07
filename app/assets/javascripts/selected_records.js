$(function(){

  $('#records').bind('change', function(){
    send_ajax('records/select_records', 'GET', {klass: this.value})
  });

});

function send_ajax(url, request_type, params){
  $.ajax({
    url: url,
    type: request_type,
    data: params
  });
};
