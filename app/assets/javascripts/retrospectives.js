$(function(){
  var find_similar_enabled = (typeof(find_similar_enabled) == 'boolean' ? find_similar_enabled : true);

  $('.modal').on('hidden', function(){
    find_similar_enabled = true;
    $(this).find('input[type=text]').val('');
    similars = $('.similar');
    similars.find('ul').empty();
    similars.slideUp();
  });

  $.fn.focusOnItem = function() {
    $(this).bind('ajax:success click', function() {
      $('.modal').modal('hide');
      item              = $('#' + $(this).parents('li').attr('data-id'));
      background_origin = item.css('backgroundColor');
      item.find('.icon-thumbs-up').focus();
      item.animate({backgroundColor: '#eee'}, 1000).delay(1000).
           animate({backgroundColor: background_origin}, 1000);
    });
  }

  $.fn.closeSimilars = function() {
    $(this).click(function(){
      find_similar_enabled = false;
      $('.similar').slideUp();
      $('.description').focus();
    });
  }

  $('.modal').find('.description').on('keyup', function(){
    input_field = $(this);
    input_value = input_field.val().trim();
    similars    = $('.similar');
    if(!find_similar_enabled && input_value == '') find_similar_enabled = true;

    if(input_value.length > 2 && find_similar_enabled) {
      url = input_field.parents('form').attr('action') + '/similar_retro_items';
      $.get(url, {q: input_value}, function(similars_data){
        similars.find('ul').html(similars_data);
        similars.slideDown();
        similars.find('.description').focusOnItem();
        similars.find('.vote').focusOnItem();
        similars.find('.close').closeSimilars();
      }, 'html').fail(function(){ similars.slideUp(); });
    } else if(input_value.length <= 2) {
      similars.slideUp();
    }
  });

  //var bads_table = setInterval(function() {
    //$.get($('.bads_table').attr('data-url'), '', function(list_items){
      //$('.bads_table').find('tbody').html(list_items);
    //});
  //}, 10000);

  //var goods_table = setInterval(function() {
    //$.get($('.goods_table').attr('data-url'), '', function(list_items){
      //$('.goods_table').find('tbody').html(list_items);
    //});
  //}, 10000);
});
