$(function(){

  $('#records').bind('change', function(){
    var klass = this.options[this.options.selectedIndex].value;
    send_ajax('records/select_records', 'GET', {klass: klass})
  });

});

function send_ajax(url, request_type, params){
  $.ajax({
    url: url,
    type: request_type,
    data: params
  });
};
