$(function(){
  $('.modal').find('.description').on('focusout keyup', function(){
    field   = $(this);
    enabled = (typeof(enabled) == 'boolean' ? enabled : true);
    if(!enabled && field.val() == '') enabled = true;

    if(field.val().length > 2 && enabled) {
      retro_id = $('#good_retrospective_id').val();
      url      = field.parents('form').attr('action') + '/similar_retro_items';
      $.get(url, {q: field.val()}, function(html_data){
        similars = $('.similar');
        similars.find('ul').html(html_data);
        similars.slideDown();
        similars.find('.close').click(function(){
          enabled = false;
          similars.slideUp();
          field.focus();
        });
      }, 'html').fail(function(){ $('.similar').slideUp(); });
    } else if(field.val().length <= 2) {
      $('.similar').slideUp();
    }
  });
});
