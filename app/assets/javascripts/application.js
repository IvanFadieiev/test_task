// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require ckeditor/init


$(document).ready(function(){
  $('a.poplight[href^=#]').click(function() {
    var popID = $(this).attr('rel'); 
    var popURL = $(this).attr('href'); 

    var query= popURL.split('?');
    var dim= query[1].split('&');
    var popWidth = dim[0].split('=')[1];
 
    $('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" title="Закрыть" class="close"></a>');
 
    var popMargTop = ($('#' + popID).height() + 80) / 2;
    var popMargLeft = ($('#' + popID).width() + 80) / 2;
 
    $('#' + popID).css({ 
      'margin-top' : -popMargTop,
      'margin-left' : -popMargLeft
    });
 
    $('body').append('<div id="fade"></div>');
    $('#fade').css({'filter' : 'alpha(opacity=80)'}).fadeIn();
 
    return false;
  });
 
  $(document).on('click', 'a.close, #fade', function() { 
    $('#fade , .popup_block').fadeOut(function() {
        $('#fade, a.close').remove(); 
    });
    return false;
   });
});

$(document).ready(function(){
  $('body div.container div.alert.alert-success').fadeOut(5000).delay(2000);
});

$(document).on('click', 'a.close', function() { 
    $('.for_reply').slideUp();
});

$(document).on('click','.btn.btn-large.btn-primary', function() { 
    $('.for_reply').slideUp();
});

$(document).ready(function(){
    $('form[data-remote]').bind('ajax:before', function(){
      for (instance in CKEDITOR.instances){
        CKEDITOR.instances[instance].updateElement();
      }
    });
  });