$(document).ready(function(){
  $('.progress-bar-social').each(function(){
    $(this).find('.progress-bar-social-bar').animate({
      height:$(this).attr('data-percent')
    },6000);
  });
});


