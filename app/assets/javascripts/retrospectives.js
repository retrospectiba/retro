$(function(){
  $('.modal').find('.description').on('keyup', function(){
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
        similars.find('.description').click(function(){
          similars.slideUp();
          field.val('');
          $('.modal').modal('hide');
          id = $(this).parents('li').attr('data-id');
          item_already_exist = $('#' + id);
          background = item_already_exist.css('backgroundColor');
          item_already_exist.animate({backgroundColor: '#eee'}, 1000).delay(1000).animate({backgroundColor: background}, 1000);
        });
        similars.find('.vote').bind('ajax:success', function(){
          similars.slideUp();
          field.val('');
          $('.modal').modal('hide');
          id = $(this).parents('li').attr('data-id');
          item_already_exist = $('#' + id);
          item_already_exist.find('.icon-thumbs-up').focus();
          background = item_already_exist.css('backgroundColor');
          item_already_exist.animate({backgroundColor: '#eee'}, 1000).delay(1000).animate({backgroundColor: background}, 1000);
        });
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
