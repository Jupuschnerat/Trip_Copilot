document.addEventListener('DOMContentLoaded', function() {
  document.addEventListener('ajax:success', function(event) {
    var postId = event.detail[0].post_id;
    var button = document.querySelector(`#favorite-button-${postId}`);

    button.classList.toggle('active');
  });
});
