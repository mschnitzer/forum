document.addEventListener("turbolinks:load", function() {
  $('.board_thread_post_new').on('ajax:complete', function(event) {
    [data, status, xhr] = event.detail;

    $('#post-new-response').html(data.responseText);
    $('#post-new-response').fadeIn(300);
  });
});
